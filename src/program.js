// Program representation and clause indexing.
// Indexes are deliberately conservative: they speed up common scalar arguments but never replace unification as the final check.
import { ATOM, COMPOUND, Env, compound, deref, flattenConjunction, isScalar, properListItems, termToString } from './term.js';
import { parseClauses } from './parser.js';

export class Program {
  constructor(clauses = [], options = {}) {
    this.clauses = clauses;
    this.groups = new Map();
    this.materializedGroups = new Set();
    this.hasMaterialize = false;
    for (let index = 0; index < this.clauses.length; index++) {
      const clause = this.clauses[index];
      clause.index = index;
      this.indexClause(clause);
    }
    this.applyDeclarations(options);
  }
  static parse(source, options = {}) {
    return new Program(parseSourceClauses(source, options), options);
  }
  static parseSources(sources = [], options = {}) {
    const clauses = [];
    for (const source of sources) {
      const parsed = typeof source === 'string'
        ? parseSourceClauses(source, options)
        : parseSourceClauses(source?.text ?? source?.source ?? '', { ...options, filename: source?.filename ?? '<input>' });
      for (const clause of parsed) clauses.push(clause);
    }
    return new Program(clauses, options);
  }
  makeGroup(name, arity) {
    // A group corresponds to one predicate indicator, for example edge/3.
    // Single-argument and pair indexes cover the common case where queries bind
    // one or two scalar arguments before calling the predicate.
    const group = {
      name,
      arity,
      clauses: [],
      argIndexes: Array.from({ length: arity }, () => ({ buckets: new Map(), fallback: [] })),
      pairIndexes: [],
      tabled: false,
      mode: null,
      determinism: null,
      recursive: false,
    };
    if (arity > 2) {
      for (let left = 0; left < arity; left++) {
        for (let right = left + 1; right < arity; right++) {
          group.pairIndexes.push({ left, right, buckets: new Map(), fallback: [] });
        }
      }
    }
    return group;
  }
  indexClause(clause) {
    const head = clause.head;
    if (head.type !== COMPOUND) return;
    const key = `${head.name}/${head.arity}`;
    let group = this.groups.get(key);
    if (!group) {
      group = this.makeGroup(head.name, head.arity);
      this.groups.set(key, group);
    }
    group.clauses.push(clause);
    for (let i = 0; i < head.arity; i++) indexOne(group.argIndexes[i], head.args[i], clause);
    for (const pair of group.pairIndexes) indexPair(pair, head, clause);
  }
  findGroup(name, arity) {
    return this.groups.get(`${name}/${arity}`) ?? null;
  }
  applyDeclarations(options = {}) {
    for (const clause of this.clauses) {
      const h = clause.head;
      if (clause.body.length !== 0 || h.type !== COMPOUND) continue;

      if (h.arity === 2) {
        const indicator = declarationIndicator(h.args[0], h.args[1]);
        if (!indicator) continue;
        const group = this.groups.get(indicator.key);
        if (h.name === 'table') {
          if (group) group.tabled = true;
        } else if (h.name === 'materialize') {
          this.hasMaterialize = true;
          this.materializedGroups.add(indicator.key);
        } else if ((h.name === 'det' || h.name === 'semidet') && group) {
          group.determinism = h.name;
        }
        continue;
      }

      if (h.name === 'mode' && h.arity === 3) {
        const indicator = declarationIndicator(h.args[0], h.args[1]);
        if (!indicator) continue;
        const modes = declarationModes(h.args[2]);
        if (modes && modes.length === indicator.arity) {
          const group = this.groups.get(indicator.key);
          if (group) group.mode = modes;
        }
      }
    }
    if (options.markRecursive !== false) this.markRecursivePredicates();
  }
  markRecursivePredicates() {
    // Recursion is a group-level diagnostic hint. It is computed from predicate
    // dependencies rather than from individual clauses when callers explicitly ask
    // for it.
    const groups = [...this.groups.values()];
    const indexByGroup = new Map(groups.map((group, i) => [group, i]));
    const deps = groups.map(() => new Set());
    for (const group of groups) {
      const groupIndex = indexByGroup.get(group);
      for (const clause of group.clauses) {
        const bodyGoals = clause.body.flatMap((goal) => goal.type === COMPOUND && goal.name === ',' && goal.arity === 2 ? flattenConjunction(goal) : [goal]);
        for (const goal of bodyGoals) {
          if (goal.type !== COMPOUND) continue;
          const dep = this.findGroup(goal.name, goal.arity);
          if (dep) deps[groupIndex].add(indexByGroup.get(dep));
        }
      }
    }
    for (const group of groups) {
      const start = indexByGroup.get(group);
      const seen = new Set();
      const stack = [start];
      let recursive = false;
      while (stack.length && !recursive) {
        const current = stack.pop();
        if (seen.has(current)) continue;
        seen.add(current);
        for (const next of deps[current]) {
          if (next === start) { recursive = true; break; }
          if (!seen.has(next)) stack.push(next);
        }
      }
      group.recursive = recursive;
    }
  }
  hasMaterializeDeclarations() {
    return this.hasMaterialize;
  }
  groupIsMaterialized(group) {
    return this.materializedGroups.has(`${group.name}/${group.arity}`);
  }
  groupHasRule(group) {
    return group.clauses.some((clause) => clause.body.length > 0);
  }
  sourceFactLines(predicateKeys = null) {
    // Only facts for predicates that may be materialized need to be remembered.
    // On data-heavy examples this avoids formatting tens of thousands of
    // unrelated source facts just to suppress duplicate derived output.
    const lines = new Set();
    const env = new Env();
    for (const clause of this.clauses) {
      if (clause.body.length !== 0 || clause.head.type !== COMPOUND) continue;
      if (predicateKeys && !predicateKeys.has(`${clause.head.name}/${clause.head.arity}`)) continue;
      lines.add(`${termToString(clause.head, env, true)}.\n`);
    }
    return lines;
  }
  materializationGoals() {
    const hasMaterialize = this.hasMaterializeDeclarations();
    const goals = [];
    for (const group of this.groups.values()) {
      if (hasMaterialize) {
        if (!this.groupIsMaterialized(group)) continue;
      } else if (group.arity !== 2) {
        continue;
      }
      if (!this.groupHasRule(group)) continue;
      const args = [];
      for (let i = 0; i < group.arity; i++) args.push({ type: 'var', name: `X${i}`, args: [] });
      goals.push(compound(group.name, args));
    }
    return goals;
  }
}


function declarationIndicator(name, arity) {
  if (name?.type !== ATOM || arity?.type !== 'number') return null;
  if (!/^\d+$/.test(arity.name)) return null;
  const arityNumber = Number(arity.name);
  return { name: name.name, arity: arityNumber, key: `${name.name}/${arityNumber}` };
}

function declarationModes(term) {
  const items = properListItems(term, new Env());
  if (!items) return null;
  const modes = [];
  for (const item of items) {
    if (item.type !== ATOM) return null;
    if (!['in', 'out', 'any'].includes(item.name)) return null;
    modes.push(item.name);
  }
  return modes;
}

function indexOne(index, arg, clause) {
  if (isScalar(arg)) {
    const bucket = index.buckets.get(arg.name);
    if (bucket) bucket.push(clause);
    else index.buckets.set(arg.name, [clause]);
  } else {
    index.fallback.push(clause);
  }
}

function pairKey(left, right) {
  return `${left.name}\x1f${right.name}`;
}

function indexPair(pair, head, clause) {
  const left = head.args[pair.left];
  const right = head.args[pair.right];
  if (isScalar(left) && isScalar(right)) {
    const key = pairKey(left, right);
    const bucket = pair.buckets.get(key);
    if (bucket) bucket.push(clause);
    else pair.buckets.set(key, [clause]);
  } else {
    pair.fallback.push(clause);
  }
}

export function selectClauseCandidates(group, goal, env) {
  // Pick the narrowest applicable index. Fallback clauses remain in the result
  // because clauses with variables or compound heads can still unify later.
  let bestPrimary = group.clauses;
  let bestFallback = [];
  let bestLen = group.clauses.length;
  let indexed = false;
  if (goal.type !== COMPOUND) return { primary: bestPrimary, fallback: bestFallback };

  for (let i = 0; i < goal.arity; i++) {
    const arg = deref(goal.args[i], env);
    if (!isScalar(arg)) continue;
    const index = group.argIndexes[i];
    const bucket = index.buckets.get(arg.name) ?? [];
    const candidateLen = bucket.length + index.fallback.length;
    if (!indexed || candidateLen < bestLen) {
      bestPrimary = bucket;
      bestFallback = index.fallback;
      bestLen = candidateLen;
      indexed = true;
      if (bestLen === 0) break;
    }
  }

  for (const pair of group.pairIndexes) {
    const left = deref(goal.args[pair.left], env);
    const right = deref(goal.args[pair.right], env);
    if (!isScalar(left) || !isScalar(right)) continue;
    const bucket = pair.buckets.get(pairKey(left, right)) ?? [];
    const candidateLen = bucket.length + pair.fallback.length;
    if (!indexed || candidateLen < bestLen) {
      bestPrimary = bucket;
      bestFallback = pair.fallback;
      bestLen = candidateLen;
      indexed = true;
      if (bestLen === 0) break;
    }
  }

  return { primary: bestPrimary, fallback: bestFallback };
}

export function makeProgram(source, options = {}) {
  return Program.parse(source, options);
}

export function parseSourceClauses(source, options = {}) {
  return parseClauses(source, options);
}
