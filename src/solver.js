// Depth-first eyelang solver with builtin dispatch, memoization, and guarded recursion handling.
// Most semantic decisions still flow through unification; optimizations only select candidates earlier.
import { COMPOUND, Env, copyResolved, flattenConjunction, freshTerm, termIsGround, termToString, unify, variantTerms } from './term.js';
import { createDefaultRegistry } from './builtins/registry.js';
import { selectClauseCandidates } from './program.js';

let freshCounter = 0;

export function nextFreshId() {
  return ++freshCounter;
}

export class Solver {
  constructor(program, options = {}) {
    this.program = program;
    this.registry = options.registry ?? createDefaultRegistry();
    this.maxDepth = options.maxDepth ?? 100000;
    this.solutionLimit = options.solutionLimit ?? 10000000;
    this.solutionsSeen = 0;
    this.active = [];
    this.memo = new Map();
    this.groundChainSuccess = new Set();
    this.stats = {
      completed_goal_lists: 0,
      solve_goals_calls: 0,
      solve_one_goal_calls: 0,
      unify_calls: 0,
      max_depth: 0,
      max_goal_count: 0,
      deterministic_builtin_successes: 0,
      deterministic_builtin_failures: 0,
    };
  }

  cloneForInnerGoal(solutionLimit = this.solutionLimit) {
    const solver = new Solver(this.program, { registry: this.registry, maxDepth: this.maxDepth, solutionLimit });
    solver.memo = this.memo;
    solver.groundChainSuccess = this.groundChainSuccess;
    return solver;
  }

  absorbStatsFrom(child) {
    if (!child || child === this || !child.stats) return;
    for (const [key, value] of Object.entries(child.stats)) {
      if (key === 'max_depth' || key === 'max_goal_count') {
        this.stats[key] = Math.max(this.stats[key] ?? 0, value ?? 0);
      } else {
        this.stats[key] = (this.stats[key] ?? 0) + (value ?? 0);
      }
    }
  }

  *solve(goals, env = new Env(), depth = 0) {
    if (!Array.isArray(goals)) goals = [goals];

    const savedActive = this.active;
    try {
      const stack = [{ kind: 'goals', goals, env, depth, active: savedActive.slice() }];
      while (stack.length) {
      const frame = stack.pop();
      if (frame.kind === 'completeMemo') {
        frame.entry.computing = false;
        frame.entry.complete = true;
        continue;
      }

      goals = frame.goals;
      env = frame.env;
      depth = frame.depth;
      let active = frame.active;

      while (true) {
        this.stats.solve_goals_calls++;
        this.stats.max_depth = Math.max(this.stats.max_depth, depth);
        this.stats.max_goal_count = Math.max(this.stats.max_goal_count, goals.length);
        if (depth > this.maxDepth || this.solutionsSeen >= this.solutionLimit) break;

        if (goals.length === 0) {
          this.solutionsSeen++;
          this.stats.completed_goal_lists++;
          this.active = active;
          yield env;
          break;
        }

        const first = goals[0];
        if (first?.kind === 'releaseActive') {
          active = active.slice(0, -1);
          goals = goals.slice(1);
          continue;
        }
        if (first?.kind === 'memoStore') {
          rememberMemoAnswer(first.entry, first.goal, env);
          goals = goals.slice(1);
          continue;
        }

        // eyelang normally solves left-to-right, but ready deterministic builtins can
        // be run early as pure filters. Stop at internal sentinels so rule-body
        // active guards are released before the caller's remaining goals are seen.
        const selectedIndex = selectReadyDeterministicBuiltin(goals, env, this.registry);
        const goal = goals[selectedIndex];
        const rest = selectedIndex === 0 ? goals.slice(1) : [...goals.slice(0, selectedIndex), ...goals.slice(selectedIndex + 1)];
        if (goal.type === COMPOUND && goal.name === ',' && goal.arity === 2) {
          goals = [...flattenConjunction(goal), ...rest];
          depth++;
          continue;
        }

        const def = goal.type === COMPOUND ? this.registry.get(goal.name, goal.arity) : null;
        this.active = active;
        if (def && builtinIsReadyOrAuthoritative(def, this, goal, env)) {
          const nextEnvs = [];
          for (const next of def.handler({ solver: this, goal, env })) nextEnvs.push(next);
          if (def.deterministic) {
            if (nextEnvs.length) this.stats.deterministic_builtin_successes++;
            else this.stats.deterministic_builtin_failures++;
          }
          if (nextEnvs.length === 0) break;
          if (nextEnvs.length === 1) {
            goals = rest;
            env = nextEnvs[0];
            depth++;
            continue;
          }
          for (let i = nextEnvs.length - 1; i >= 0; i--) {
            stack.push({ kind: 'goals', goals: rest, env: nextEnvs[i], depth: depth + 1, active });
          }
          break;
        }

        this.stats.solve_one_goal_calls++;
        if (goal.type !== COMPOUND) break;
        const group = this.program.findGroup(goal.name, goal.arity);
        if (!group) break;

        if (group.tabled) {
          const key = memoKey(goal, env);
          if (key.hasBound) {
            const mapKey = `${goal.name}/${goal.arity}:${key.text}`;
            let entry = this.memo.get(mapKey);
            if (!entry) {
              entry = { computing: false, complete: false, answers: [], answerKeys: new Set() };
              this.memo.set(mapKey, entry);
            }
            if (entry.complete) {
              pushMemoAnswerFrames(stack, entry, goal, rest, env, depth, active, this);
              break;
            }
            if (!entry.computing) {
              entry.computing = true;
              stack.push({ kind: 'completeMemo', entry });
              pushUserGoalUncachedFrames(stack, this, group, goal, [{ kind: 'memoStore', entry, goal }, ...rest], env, depth, active);
              break;
            }
          }
        }

        pushUserGoalUncachedFrames(stack, this, group, goal, rest, env, depth, active);
        break;
      }
      }
    } finally {
      this.active = savedActive;
    }
  }

  activeVariant(goal, env) {
    return activeVariantIn(goal, env, this.active);
  }

  *solveUserGoal(goal, rest, env, depth) {
    this.stats.solve_one_goal_calls++;
    if (depth > this.maxDepth || this.solutionsSeen >= this.solutionLimit) return;
    if (goal.type !== COMPOUND) return;
    const group = this.program.findGroup(goal.name, goal.arity);
    if (!group) return;
    if (group.tabled) {
      yield* this.solveMemoizedGoal(group, goal, rest, env, depth);
      return;
    }
    yield* this.solveUserGoalUncached(group, goal, rest, env, depth);
  }

  *solveMemoizedGoal(group, goal, rest, env, depth) {
    // Memoization only pays off when at least one argument is bound. A fully
    // open call would require storing the entire relation and can mask useful
    // goal-ordering behavior, so it falls back to the normal path.
    const key = memoKey(goal, env);
    if (!key.hasBound) {
      yield* this.solveUserGoalUncached(group, goal, rest, env, depth);
      return;
    }
    const mapKey = `${goal.name}/${goal.arity}:${key.text}`;
    let entry = this.memo.get(mapKey);
    if (!entry) {
      entry = { computing: false, complete: false, answers: [] };
      this.memo.set(mapKey, entry);
    }
    if (!entry.complete && !entry.computing) {
      entry.computing = true;
      const collector = this.cloneForInnerGoal();
      for (const answerEnv of collector.solveUserGoalUncached(group, goal, [], env.clone(), depth)) {
        entry.answers.push(goal.args.map((arg) => importResolved(arg, answerEnv)));
      }
      entry.computing = false;
      entry.complete = true;
    }
    if (!entry.complete && entry.computing) {
      yield* this.solveUserGoalUncached(group, goal, rest, env, depth);
      return;
    }
    for (const answerArgs of entry.answers) {
      const next = env.clone();
      let ok = true;
      for (let i = 0; i < goal.arity; i++) {
        this.stats.unify_calls++;
        if (!unify(goal.args[i], answerArgs[i], next)) { ok = false; break; }
      }
      if (ok) yield* this.solve(rest, next, depth + 1);
      if (this.solutionsSeen >= this.solutionLimit) return;
    }
  }

  *solveUserGoalUncached(group, goal, rest, env, depth) {
    if (this.activeVariant(goal, env)) return;
    // Program indexes provide candidate clauses, but every candidate is still
    // freshened and unified below. The index is a performance hint, not a
    // semantic shortcut.
    const candidates = selectClauseCandidates(group, goal, env);
    for (const pass of [candidates.primary, candidates.fallback]) {
      for (const clause of pass) {
        if (headCannotMatch(goal, clause.head, env)) continue;
        const id = nextFreshId();
        const freshHead = freshTerm(clause.head, id);
        const freshBody = clause.body.map((term) => freshTerm(term, id));
        const next = env.clone();
        this.stats.unify_calls++;
        if (!unify(goal, freshHead, next)) continue;
        if (freshBody.length === 0) {
          yield* this.solve(rest, next, depth + 1);
        } else {
          yield* this.solveRuleBodyThenRest(goal, env, freshBody, rest, next, depth);
        }
        if (this.solutionsSeen >= this.solutionLimit) return;
      }
    }
  }
  *solveRuleBodyThenRest(goal, goalEnv, body, rest, env, depth) {
    // Match the C engine's active-call lifetime: the active guard protects
    // expansion of the current rule body, but it must be released before
    // the caller's remaining goals are solved. Keeping the goal active
    // through rest goals over-prunes valid transitive/recursive derivations.
    this.active.push({ goal, env: goalEnv });
    for (const bodyEnv of this.solve(body, env, depth + 1)) {
      if (this.solutionsSeen > 0) this.solutionsSeen--;
      this.active.pop();
      yield* this.solve(rest, bodyEnv, depth + 1);
      this.active.push({ goal, env: goalEnv });
      if (this.solutionsSeen >= this.solutionLimit) break;
    }
    this.active.pop();
  }

}


function pushMemoAnswerFrames(stack, entry, goal, rest, env, depth, active, solver) {
  for (let answerIndex = entry.answers.length - 1; answerIndex >= 0; answerIndex--) {
    const answerArgs = entry.answers[answerIndex];
    const next = env.clone();
    let ok = true;
    for (let i = 0; i < goal.arity; i++) {
      solver.stats.unify_calls++;
      if (!unify(goal.args[i], answerArgs[i], next)) { ok = false; break; }
    }
    if (ok) stack.push({ kind: 'goals', goals: rest, env: next, depth: depth + 1, active });
  }
}

function pushUserGoalUncachedFrames(stack, solver, group, goal, rest, env, depth, active) {
  if (activeVariantIn(goal, env, active)) return;
  if (tryPushGroundChainFrames(stack, solver, group, goal, rest, env, depth, active)) return;
  const candidates = selectClauseCandidates(group, goal, env);
  const frames = [];
  for (const pass of [candidates.primary, candidates.fallback]) {
    for (const clause of pass) {
      if (headCannotMatch(goal, clause.head, env)) continue;
      const id = nextFreshId();
      const freshHead = freshTerm(clause.head, id);
      const freshBody = clause.body.map((term) => freshTerm(term, id));
      const next = env.clone();
      solver.stats.unify_calls++;
      if (!unify(goal, freshHead, next)) continue;
      if (freshBody.length === 0) {
        frames.push({ kind: 'goals', goals: rest, env: next, depth: depth + 1, active });
      } else {
        frames.push({
          kind: 'goals',
          goals: [...freshBody, { kind: 'releaseActive' }, ...rest],
          env: next,
          depth: depth + 1,
          active: [...active, { goal, env }],
        });
      }
    }
  }
  for (let i = frames.length - 1; i >= 0; i--) stack.push(frames[i]);
}


function tryPushGroundChainFrames(stack, solver, group, goal, rest, env, depth, active) {
  // Compress deterministic ground single-goal chains such as deep taxonomy
  // proofs: a(ind, n100000) -> a(ind, n99999) -> ... -> a(ind, n0).
  // This is a search-control optimization only. It fires only while each step
  // has exactly one matching clause and a single ground body goal; otherwise the
  // normal clause path below remains authoritative.
  if (!termIsGround(goal, env)) return false;

  const baseEnv = env;
  let currentGroup = group;
  let currentGoal = copyResolved(goal, env);
  let currentDepth = depth;
  const currentEnv = new Env();
  const seen = new Set();

  while (true) {
    // The compressed path is iterative and protected by `seen`, so it does not
    // consume JavaScript recursion depth the way the ordinary solver path does.
    // Keep recording the logical depth for diagnostics, but do not cut off long
    // finite taxonomy chains with the recursive maxDepth guard.
    if (solver.solutionsSeen >= solver.solutionLimit) return true;
    solver.stats.max_depth = Math.max(solver.stats.max_depth, currentDepth);
    const key = `${currentGoal.name}/${currentGoal.arity}:${termToString(currentGoal, currentEnv, true)}`;
    if (seen.has(key)) return true;
    if (activeVariantIn(currentGoal, currentEnv, active)) return true;
    if (solver.groundChainSuccess.has(key)) {
      rememberGroundChainSuccess(solver, seen);
      stack.push({ kind: 'goals', goals: rest, env: baseEnv, depth: depth + 1, active });
      return true;
    }
    seen.add(key);

    const candidates = selectClauseCandidates(currentGroup, currentGoal, currentEnv);
    const matches = [];
    for (const pass of [candidates.primary, candidates.fallback]) {
      for (const clause of pass) {
        if (headCannotMatch(currentGoal, clause.head, currentEnv)) continue;
        const id = nextFreshId();
        const freshHead = freshTerm(clause.head, id);
        const freshBody = clause.body.map((term) => freshTerm(term, id));
        const next = new Env();
        solver.stats.unify_calls++;
        if (!unify(currentGoal, freshHead, next)) continue;
        matches.push({ body: freshBody, env: next });
        if (matches.length > 1) return false;
      }
    }

    if (matches.length !== 1) return false;
    const match = matches[0];
    if (match.body.length === 0) {
      rememberGroundChainSuccess(solver, seen);
      stack.push({ kind: 'goals', goals: rest, env: baseEnv, depth: depth + 1, active });
      return true;
    }
    if (match.body.length !== 1) return false;
    const nextGoal = match.body[0];
    if (nextGoal.type !== COMPOUND || !termIsGround(nextGoal, match.env)) return false;
    const resolvedNextGoal = copyResolved(nextGoal, match.env);
    const nextGroup = solver.program.findGroup(resolvedNextGoal.name, resolvedNextGoal.arity);
    if (!nextGroup) return false;

    currentGoal = resolvedNextGoal;
    currentGroup = nextGroup;
    currentDepth++;
  }
}


function rememberGroundChainSuccess(solver, seen) {
  for (const key of seen) solver.groundChainSuccess.add(key);
}

function rememberMemoAnswer(entry, goal, env) {
  const answerArgs = goal.args.map((arg) => importResolved(arg, env));
  const key = answerArgs.map((arg) => termToString(arg, new Env(), true)).join('\x1f');
  if (entry.answerKeys.has(key)) return;
  entry.answerKeys.add(key);
  entry.answers.push(answerArgs);
}

function activeVariantIn(goal, env, active) {
  return active.some((entry) => variantTerms(goal, env, entry.goal, entry.env));
}


function builtinIsReadyOrAuthoritative(def, solver, goal, env) {
  if (typeof def.shouldUse === 'function' && !def.shouldUse({ solver, goal, env })) return false;
  if (typeof def.ready !== 'function') return true;
  if (def.ready(goal, env)) return true;
  return !def.fallbackWhenNotReady;
}

function selectReadyDeterministicBuiltin(goals, env, registry) {
  for (let i = 0; i < goals.length; i++) {
    const goal = goals[i];
    if (goal?.kind === 'releaseActive' || goal?.kind === 'memoStore') return 0;
    if (goal.type !== COMPOUND) continue;
    const def = registry.get(goal.name, goal.arity);
    if (!def?.deterministic || typeof def.ready !== 'function') continue;
    if (typeof def.shouldUse === 'function') continue;
    if (def.ready(goal, env)) return i;
  }
  return 0;
}

function headCannotMatch(goal, head, env) {
  if (goal.type !== COMPOUND || head.type !== COMPOUND) return false;
  if (goal.name !== head.name || goal.arity !== head.arity) return true;
  for (let i = 0; i < goal.arity; i++) {
    const a = goal.args[i];
    const b = head.args[i];
    // Keep this only as a cheap scalar rejection. unify() remains authoritative.
    const da = derefForLocal(a, env);
    if (da.args?.length === 0 && ['atom', 'string', 'number'].includes(da.type) && ['atom', 'string', 'number'].includes(b.type) && da.name !== b.name) return true;
  }
  return false;
}

function derefForLocal(term, env) {
  let current = term;
  while (current.type === 'var' && env.has(current.name)) current = env.get(current.name);
  return current;
}

function memoKey(goal, env) {
  let hasBound = false;
  const parts = goal.args.map((arg) => {
    const value = derefForLocal(arg, env);
    if (value.type !== 'var') hasBound = true;
    return value.type === 'var' ? '_' : termToString(value, env, true);
  });
  return { hasBound, text: parts.join('|') };
}

function importResolved(term, env) {
  const { copyResolved } = termModuleCache;
  return copyResolved(term, env);
}

// Avoid circular import surprises in older Node loaders.
import * as termModuleCache from './term.js';
