#!/usr/bin/env node
// Supplemental regression runner.
// This file collects focused checks that do not belong to the public
// conformance corpus or the example-output corpus: CLI regressions, public API
// checks, and small white-box tests for maintenance-sensitive internals.
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import * as publicApi from '../src/index.js';
import {
  run,
  Program,
  makeProgram,
  Solver,
  Env,
  BuiltinRegistry,
  createDefaultRegistry,
  atom,
  compound,
  listFromItems,
  numberTerm,
  stringTerm,
  variable,
  copyResolved,
  flattenConjunction,
  properListItems,
  termIsGround,
  termToString,
  unify,
  variantTerms,
  parseProgramText,
} from '../src/index.js';
import { parseGoalText } from '../src/parser.js';
import { selectClauseCandidates } from '../src/program.js';
import { TestReporter, isMainModule } from './test-style.mjs';
import { hashHex } from '../src/hash.js';

const testRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)));
const packageRoot = path.resolve(testRoot, '..');
const runtimeRoot = path.join(packageRoot, 'src');
const bin = path.join(runtimeRoot, 'bin.js');
const pkg = JSON.parse(fs.readFileSync(path.join(packageRoot, 'package.json'), 'utf8'));
let tmp = null;
let tmpCounter = 0;

export function runRegression(reporter = new TestReporter()) {
  tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'eyelang-regression.'));
  tmpCounter = 0;

  try {
    runSection(reporter, 'Regression', regressionCases());
    runSection(reporter, 'Documentation sync', documentationSyncCases());
    runSection(reporter, 'API', apiCases());
    runSection(reporter, 'White-box', whiteBoxCases());
  } finally {
    fs.rmSync(tmp, { recursive: true, force: true });
    tmp = null;
  }
}

function regressionCases() {
  return [
    {
      name: '--proof rule fact explanation output',
      run: () => runWhy({
        program: 'type(socrates, man).\ntype(X, mortal) :- type(X, man).\n',
        goalText: 'type(socrates, mortal)',
        expected: `type(socrates, mortal).
why(
  type(socrates, mortal),
  proof(
    goal(type(socrates, mortal)),
    by(rule("__FILE__", clause(2))),
    bindings([binding("X", socrates)]),
    uses([
      proof(
        goal(type(socrates, man)),
        by(fact("__FILE__", clause(1)))
      )
    ])
  )
).

`,
      }),
    },
    {
      name: '--proof numeric builtin explanation output',
      run: () => runWhy({
        program: 'p(X) :- between(536, 536, X).\n',
        goalText: 'p(536)',
        expected: `p(536).
why(
  p(536),
  proof(
    goal(p(536)),
    by(rule("__FILE__", clause(1))),
    bindings([binding("X", 536)]),
    uses([
      proof(
        goal(between(536, 536, 536)),
        by(builtin(between, 3))
      )
    ])
  )
).

`,
      }),
    },
    {
      name: '--proof list builtin explanation output',
      run: () => runWhy({
        program: 'p(X) :- member(X, [a]).\n',
        goalText: 'p(a)',
        expected: `p(a).
why(
  p(a),
  proof(
    goal(p(a)),
    by(rule("__FILE__", clause(1))),
    bindings([binding("X", a)]),
    uses([
      proof(
        goal(member(a, [a])),
        by(builtin(member, 2))
      )
    ])
  )
).

`,
      }),
    },
    {
      name: 'explanation backtracks across earlier subgoal alternatives',
      run: () => {
        const result = runWhyLoose({
          program: 'p(ok) :- q(X), r(X).\nq(a).\nq(b).\nr(b).\n',
          goalText: 'p(ok)',
        });
        assertIncludes(result.stdout, 'goal(q(b)),\n        by(fact("', 'stdout');
        assertIncludes(result.stdout, 'goal(r(b)),\n        by(fact("', 'stdout');
        assertNotIncludes(result.stdout, 'no_proof', 'stdout');
      },
    },
    {
      name: 'explanation releases active call before caller rest goals',
      run: () => {
        const result = runWhyLoose({
          program: 'p(ok) :- q(1), q(1).\nq(0).\nq(1) :- q(0).\n',
          goalText: 'p(ok)',
        });
        assertIncludes(result.stdout, 'goal(p(ok)),\n    by(rule("', 'stdout');
        assertIncludes(result.stdout, 'goal(q(1)),\n        by(rule("', 'stdout');
        assertNotIncludes(result.stdout, 'no_proof', 'stdout');
      },
    },
    {
      name: 'EYELANG_LOCAL_TIME fixes local_time builtin',
      run: () => {
        const result = runCli(['-'], {
          input: 'materialize(local_time_answer, 1).\nlocal_time_answer(D) :- local_time(D).\n',
          env: { EYELANG_LOCAL_TIME: '2024-01-02' },
        });
        assertEqual(result.status, 0, 'exit status');
        assertEqual(result.stdout, 'local_time_answer("2024-01-02").\n', 'stdout');
        assertEqual(result.stderr, '', 'stderr');
      },
    },
    {
      name: 'help with no arguments',
      run: () => {
        const result = runCli([]);
        assertEqual(result.status, 0, 'exit status');
        assertIncludes(result.stdout, 'Usage:\n  eyelang [options] [file-or-url.pl|- ...]', 'stdout');
        assertIncludes(result.stdout, '-p, --proof', 'stdout');
        assertIncludes(result.stdout, '-s, --stats', 'stdout');
        assertEqual(result.stderr, '', 'stderr');
      },
    },
    {
      name: 'version comes from package.json',
      run: () => {
        const result = runCli(['--version']);
        assertEqual(result.status, 0, 'exit status');
        assertEqual(result.stdout, `eyelang ${pkg.version}\n`, 'stdout');
        assertEqual(result.stderr, '', 'stderr');
      },
    },
    {
      name: 'stdin input is accepted',
      run: () => {
        const result = runCli(['-'], { input: 'p(a, b).\nq(X, Y) :- p(X, Y).\n' });
        assertEqual(result.status, 0, 'exit status');
        assertEqual(result.stdout, 'q(a, b).\n', 'stdout');
        assertEqual(result.stderr, '', 'stderr');
      },
    },

    {
      name: '--proof enables materialization explanations',
      run: () => {
        const result = runCli(['--proof', '-'], { input: 'p(a, b).\nq(X, Y) :- p(X, Y).\n' });
        assertEqual(result.status, 0, 'exit status');
        assertIncludes(result.stdout, 'q(a, b).\nwhy(', 'stdout');
        assertEqual(result.stderr, '', 'stderr');
      },
    },
    {
      name: '-p enables materialization explanations',
      run: () => {
        const result = runCli(['-p', '-'], { input: 'p(a, b).\nq(X, Y) :- p(X, Y).\n' });
        assertEqual(result.status, 0, 'exit status');
        assertIncludes(result.stdout, 'q(a, b).\nwhy(', 'stdout');
        assertEqual(result.stderr, '', 'stderr');
      },
    },


    {
      name: '--stats prints solver statistics to stderr',
      run: () => {
        const result = runCli(['--stats', '-'], { input: 'p(a, b).\nq(X, Y) :- p(X, Y).\n' });
        assertEqual(result.status, 0, 'exit status');
        assertEqual(result.stdout, 'q(a, b).\n', 'stdout');
        assertIncludes(result.stderr, 'eyelang stats:\n', 'stderr');
        assertIncludes(result.stderr, '  solve_goals_calls:', 'stderr');
      },
    },
    {
      name: '-s prints solver statistics to stderr',
      run: () => {
        const result = runCli(['-s', '-'], { input: 'p(a, b).\nq(X, Y) :- p(X, Y).\n' });
        assertEqual(result.status, 0, 'exit status');
        assertEqual(result.stdout, 'q(a, b).\n', 'stdout');
        assertIncludes(result.stderr, 'eyelang stats:\n', 'stderr');
        assertIncludes(result.stderr, '  solve_goals_calls:', 'stderr');
      },
    },


    {
      name: 'double dash permits option-shaped file names',
      run: () => {
        const file = path.join(tmp, '-h');
        fs.writeFileSync(file, 'p(a, b).\nq(X, Y) :- p(X, Y).\n');
        const result = runCli(['--', file]);
        assertEqual(result.status, 0, 'exit status');
        assertEqual(result.stdout, 'q(a, b).\n', 'stdout');
        assertEqual(result.stderr, '', 'stderr');
      },
    },
  ];
}


function documentationSyncCases() {
  return [
    {
      name: 'language reference builtins match runtime registry',
      run: () => assertArrayEqual(languageReferenceBuiltinNames(), registeredBuiltinNames(), 'builtins'),
    },
    {
      name: 'guide builtin catalog matches runtime registry',
      run: () => {
        assertArrayEqual(guideBuiltinNames(), registeredBuiltinNames(), 'builtins');
        const summary = guideBuiltinSummary();
        const actual = registeredBuiltinSummary();
        assertEqual(summary.entries, actual.entries, 'builtin entry count');
        assertEqual(summary.names, actual.names, 'builtin predicate name count');
      },
    },
    {
      name: 'guide example catalog matches examples directory',
      run: () => assertArrayEqual(guideCatalogExampleNames(), listExampleNames(), 'example catalog'),
    },
    {
      name: 'documentation local links and anchors resolve',
      run: () => assertArrayEqual(findBrokenDocLinks(), [], 'broken documentation links'),
    },
    {
      name: 'documented npm scripts exist in package.json',
      run: () => assertArrayEqual(missingDocumentedPackageScripts(), [], 'missing documented npm scripts'),
    },
  ];
}

function apiCases() {
  return [
    {
      name: 'public type declarations match runtime exports',
      run: () => assertArrayEqual(declaredValueExportNames(), runtimeExportNames(), 'public value exports'),
    },
    {
      name: 'run materialization through public API without proof by default',
      run: () => {
        const result = run('p(a, b).\nq(X, Y) :- p(X, Y).\n');
        assertEqual(result.stdout, 'q(a, b).\n', 'stdout');
      },
    },

    {
      name: 'portable hash helpers match standard vectors',
      run: () => {
        assertEqual(hashHex('md5', 'abc'), '900150983cd24fb0d6963f7d28e17f72', 'md5');
        assertEqual(hashHex('sha', 'abc'), 'a9993e364706816aba3e25717850c26c9cd0d89d', 'sha1');
        assertEqual(hashHex('sha256', 'abc'), 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad', 'sha256');
        assertEqual(hashHex('sha512', 'abc'), 'ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f', 'sha512');
      },
    },


    {
      name: 'run materialization can enable proof explanations',
      run: () => {
        const result = run('p(a, b).\nq(X, Y) :- p(X, Y).\n', { proof: true });
        assertIncludes(result.stdout, 'q(a, b).\nwhy(', 'stdout');
      },
    },

    {
      name: 'run accepts Program instances',
      run: () => {
        const program = Program.parse('p(a, b).\nq(X, Y) :- p(X, Y).\n');
        const result = run(program);
        assertEqual(result.stdout, 'q(a, b).\n', 'stdout');
      },
    },
    {
      name: 'makeProgram creates indexed programs',
      run: () => {
        const program = makeProgram('edge(a, b).\npath(X, Y) :- edge(X, Y).\n');
        const group = program.findGroup('path', 2);
        assertEqual(Boolean(group), true, 'path/2 group exists');
        assertEqual(group.groupName ?? group.name, 'path', 'group name');
        assertEqual(group.arity, 2, 'group arity');
      },
    },
    {
      name: 'program and solver public classes',
      run: () => {
        const program = Program.parse('p(a).\np(b).\n');
        const solver = new Solver(program);
        const goal = parseGoalText('p(X)');
        const answers = [...solver.solve([goal], new Env(), 0)].map((env) => termToString(goal, env, true));
        assertEqual(answers.join('\n'), 'p(a)\np(b)', 'answers');
      },
    },
    {
      name: 'solver honors solution limits',
      run: () => {
        const program = Program.parse('p(a).\np(b).\np(c).\n');
        const solver = new Solver(program, { solutionLimit: 2 });
        const goal = parseGoalText('p(X)');
        const answers = [...solver.solve([goal], new Env(), 0)].map((env) => termToString(goal, env, true));
        assertEqual(answers.join('\n'), 'p(a)\np(b)', 'answers');
      },
    },
    {
      name: 'custom builtin registry can be embedded',
      run: () => {
        const registry = new BuiltinRegistry();
        registry.add('hello', 1, function* ({ goal, env }) {
          const next = env.clone();
          if (unify(goal.args[0], atom('world'), next)) yield next;
        });
        const program = Program.parse('answer(X) :- hello(X).\n');
        const solver = new Solver(program, { registry });
        const goal = parseGoalText('answer(X)');
        const answers = [...solver.solve([goal], new Env(), 0)].map((env) => termToString(goal, env, true));
        assertEqual(answers.join('\n'), 'answer(world)', 'answers');
      },
    },
    {
      name: 'default builtin registry exposes expected metadata',
      run: () => {
        const registry = createDefaultRegistry();
        const between = registry.get('between', 3);
        const append = registry.get('append', 3);
        assertEqual(Boolean(between), true, 'between/3 exists');
        assertEqual(Boolean(append), true, 'append/3 exists');
        assertEqual(between.name, 'between', 'between name');
        assertEqual(append.arity, 3, 'append arity');
      },
    },
  ];
}

function whiteBoxCases() {
  return [
    {
      name: 'unification binds variables in Env',
      run: () => {
        const env = new Env();
        assertEqual(unify(variable('X'), atom('socrates'), env), true, 'unify result');
        assertEqual(termToString(variable('X'), env, true), 'socrates', 'binding');
      },
    },
    {
      name: 'copyResolved and termIsGround follow bindings',
      run: () => {
        const env = new Env();
        const term = compound('p', [variable('X'), atom('b')]);
        assertEqual(termIsGround(term, env), false, 'not ground before binding');
        assertEqual(unify(variable('X'), atom('a'), env), true, 'bind X');
        const resolved = copyResolved(term, env);
        assertEqual(termToString(resolved, new Env(), true), 'p(a, b)', 'resolved term');
        assertEqual(termIsGround(resolved), true, 'ground after copy');
      },
    },

    {
      name: 'parser rejects non-Prolog unquoted atom spelling',
      run: () => {
        let threw = false;
        try { parseProgramText('value(a-b, ok).\n'); } catch (_) { threw = true; }
        assertEqual(threw, true, 'a-b must be quoted');
      },
    },
    {
      name: 'parser rejects zero-arity compound syntax',
      run: () => {
        let threw = false;
        try { parseProgramText('value(nil(), ok).\n'); } catch (_) { threw = true; }
        assertEqual(threw, true, 'zero-arity compound rejection');
      },
    },
    {
      name: 'parser preserves list syntax readback',
      run: () => {
        const goal = parseGoalText('member(X, [a, b])');
        assertEqual(termToString(goal, new Env(), true), 'member(X, [a, b])', 'goal');
      },
    },
    {
      name: 'list construction round-trips through properListItems',
      run: () => {
        const list = listFromItems([atom('a'), numberTerm(2), stringTerm('c')]);
        const items = properListItems(list, new Env());
        assertEqual(items.length, 3, 'length');
        assertEqual(termToString(list, new Env(), true), '[a, 2, "c"]', 'list text');
      },
    },
    {
      name: 'variantTerms recognizes alpha-equivalent goals',
      run: () => {
        const left = parseGoalText('edge(X, Y)');
        const right = parseGoalText('edge(A, B)');
        const nonVariant = parseGoalText('edge(A, A)');
        assertEqual(variantTerms(left, new Env(), right, new Env()), true, 'variant');
        assertEqual(variantTerms(left, new Env(), nonVariant, new Env()), false, 'non-variant');
      },
    },
    {
      name: 'flattenConjunction preserves left-to-right order',
      run: () => {
        const goal = parseGoalText('(a, b, c)');
        const parts = flattenConjunction(goal).map((part) => termToString(part, new Env(), true));
        assertEqual(parts.join(' | '), 'a | b | c', 'order');
      },
    },
    {
      name: 'parseProgramText returns clause objects',
      run: () => {
        const clauses = parseProgramText('p(a).\nq(X) :- p(X).\n');
        assertEqual(clauses.length, 2, 'clause count');
        assertEqual(termToString(clauses[1].head, new Env(), true), 'q(X)', 'rule head');
        assertEqual(clauses[1].body.length, 1, 'body length');
      },
    },
    {
      name: 'clause candidate selection uses scalar indexes with fallback',
      run: () => {
        const program = Program.parse('edge(a, b).\nedge(c, d).\nedge(X, z).\n');
        const group = program.findGroup('edge', 2);
        const goal = parseGoalText('edge(a, Y)');
        const candidates = selectClauseCandidates(group, goal, new Env());
        assertEqual(candidates.primary.length, 1, 'primary bucket length');
        assertEqual(candidates.fallback.length, 1, 'fallback length');
        assertEqual(termToString(candidates.primary[0].head, new Env(), true), 'edge(a, b)', 'primary head');
      },
    },
  ];
}

function runSection(reporter, name, cases) {
  reporter.section(name);
  for (const testCase of cases) reporter.test(testCase.name, testCase.run);
  reporter.sectionTotal(sectionLabel(name));
}

function sectionLabel(name) {
  if (name === 'Documentation sync') return 'documentation sync';
  if (name === 'API') return 'API';
  if (name === 'White-box') return 'white-box';
  return name.toLowerCase();
}

function runWhy({ program, goalText, expected }) {
  const programFile = path.join(tmp, `${++tmpCounter}.pl`);
  fs.writeFileSync(programFile, program);
  const goal = parseGoalText(goalText);
  fs.appendFileSync(programFile, `\nmaterialize(${goal.name}, ${goal.arity}).\n`);
  const result = runCli(['--proof', programFile]);
  assertEqual(result.status, 0, 'exit status');
  assertEqual(result.stderr, '', 'stderr');
  const expectedText = expected.replaceAll('__FILE__', path.basename(programFile));
  assertEqual(result.stdout, expectedText, 'stdout');

  Program.parse(result.stdout);
  assertIncludes(result.stdout, '  proof(\n', 'stdout');
  assertIncludes(result.stdout, ' by(rule("', 'stdout');
  assertIncludes(result.stdout, ', clause(', 'stdout');
  assertNotIncludes(result.stdout, 'source(head(', 'stdout');
  assertIncludes(result.stdout, '\n).\n\n', 'stdout');
}

function runWhyLoose({ program, goalText }) {
  const programFile = path.join(tmp, `${++tmpCounter}.pl`);
  fs.writeFileSync(programFile, program);
  const goal = parseGoalText(goalText);
  fs.appendFileSync(programFile, `\nmaterialize(${goal.name}, ${goal.arity}).\n`);
  const result = runCli(['--proof', programFile]);
  assertEqual(result.status, 0, 'exit status');
  assertEqual(result.stderr, '', 'stderr');
  Program.parse(result.stdout);
  assertIncludes(result.stdout, '\n).\n\n', 'stdout');
  return result;
}

function listExampleNames() {
  return fs.readdirSync(path.join(packageRoot, 'examples'))
    .filter((name) => name.endsWith('.pl'))
    .map((name) => name.slice(0, -3))
    .sort();
}

function guideCatalogExampleNames() {
  const guide = fs.readFileSync(path.join(packageRoot, 'docs', 'guide.md'), 'utf8');
  const section = between(guide, '## Example catalog', '## Golden outputs, tests, and conformance');
  return [...section.matchAll(/examples\/([A-Za-z0-9_-]+)\.pl/g)]
    .map((match) => match[1])
    .filter((name, index, names) => names.indexOf(name) === index)
    .sort();
}

function registeredBuiltinNames() {
  return [...createDefaultRegistry().defs.keys()].sort();
}

function registeredBuiltinSummary() {
  const names = registeredBuiltinNames();
  return {
    entries: names.length,
    names: new Set(names.map((name) => name.split('/')[0])).size,
  };
}

function guideBuiltinNames() {
  const guide = fs.readFileSync(path.join(packageRoot, 'docs', 'guide.md'), 'utf8');
  return documentedBuiltinNames(between(guide, '### Builtins', '## Aggregation helpers'));
}

function guideBuiltinSummary() {
  const guide = fs.readFileSync(path.join(packageRoot, 'docs', 'guide.md'), 'utf8');
  const section = between(guide, '### Builtins', '## Aggregation helpers');
  const match = section.match(/currently registers (\d+) name\/arity entries across (\d+) predicate names/);
  if (match == null) throw new Error('guide builtin summary not found');
  return { entries: Number(match[1]), names: Number(match[2]) };
}

function languageReferenceBuiltinNames() {
  const reference = fs.readFileSync(path.join(packageRoot, 'docs', 'language-reference.md'), 'utf8');
  return documentedBuiltinNames(between(reference, '## 9. Standard built-in predicates', '## 10. Implementation-specific built-ins'));
}

function documentedBuiltinNames(section) {
  const names = [];
  for (const line of section.split('\n')) {
    if (!line.trim().startsWith('|') || !line.includes('`')) continue;
    for (const match of line.matchAll(/`([A-Za-z_][A-Za-z0-9_]*)\(([^`)]*)\)`/g)) {
      const arity = match[2].trim() === '' ? 0 : match[2].split(',').length;
      names.push(`${match[1]}/${arity}`);
    }
    for (const match of line.matchAll(/`([A-Za-z_][A-Za-z0-9_]*)\/(\d+)`/g)) {
      names.push(`${match[1]}/${match[2]}`);
    }
  }
  return [...new Set(names)].sort();
}

function runtimeExportNames() {
  return Object.keys(publicApi).sort();
}

function declaredValueExportNames() {
  const dts = fs.readFileSync(path.join(packageRoot, 'index.d.ts'), 'utf8');
  return [...dts.matchAll(/^export\s+(?:declare\s+)?(?:class|function|const)\s+([A-Za-z_][A-Za-z0-9_]*)/gm)]
    .map((match) => match[1])
    .filter((name, index, names) => names.indexOf(name) === index)
    .sort();
}

function missingDocumentedPackageScripts() {
  const docs = documentationFiles();
  const missing = [];
  for (const file of docs) {
    const text = fs.readFileSync(file, 'utf8');
    for (const line of text.split('\n')) {
      const trimmed = line.trim();
      if (!trimmed.startsWith('npm ') && !line.includes('`npm ')) continue;
      for (const match of line.matchAll(/\bnpm\s+(?:run\s+)?([A-Za-z0-9:_-]+)/g)) {
        const command = match[1];
        if (command === 'install') continue;
        const script = command === 'test' ? 'test' : command;
        if (!pkg.scripts?.[script]) missing.push(`${path.relative(packageRoot, file)}: npm ${command === 'test' ? 'test' : `run ${script}`}`);
      }
    }
  }
  return [...new Set(missing)].sort();
}

function findBrokenDocLinks() {
  const broken = [];
  const anchorsByFile = new Map();
  for (const file of documentationFiles()) {
    const text = fs.readFileSync(file, 'utf8');
    for (const target of markdownLinkTargets(text)) {
      if (/^(?:https?:|mailto:)/i.test(target)) continue;
      const [targetPathRaw, fragmentRaw] = target.split('#');
      const targetPath = targetPathRaw === '' ? file : path.resolve(path.dirname(file), decodeURI(targetPathRaw));
      const display = `${path.relative(packageRoot, file)} -> ${target}`;
      if (!fs.existsSync(targetPath)) {
        broken.push(`${display} (missing target)`);
        continue;
      }
      if (fragmentRaw != null && fragmentRaw !== '') {
        const anchors = anchorsByFile.get(targetPath) ?? markdownAnchors(targetPath);
        anchorsByFile.set(targetPath, anchors);
        if (!anchors.has(fragmentRaw)) broken.push(`${display} (missing heading #${fragmentRaw})`);
      }
    }
  }
  return broken.sort();
}

function documentationFiles() {
  return [
    path.join(packageRoot, 'README.md'),
    path.join(packageRoot, 'docs', 'guide.md'),
    path.join(packageRoot, 'docs', 'language-reference.md'),
  ];
}

function markdownLinkTargets(text) {
  return [...text.matchAll(/!?\[[^\]\n]*\]\(([^)\s]+)(?:\s+"[^"]*")?\)/g)].map((match) => match[1]);
}

function markdownAnchors(file) {
  if (!file.endsWith('.md')) return new Set();
  const text = fs.readFileSync(file, 'utf8');
  const anchors = new Set();
  const counts = new Map();
  for (const match of text.matchAll(/^#{1,6}\s+(.+)$/gm)) {
    const base = githubSlug(match[1]);
    const count = counts.get(base) ?? 0;
    counts.set(base, count + 1);
    anchors.add(count === 0 ? base : `${base}-${count}`);
  }
  return anchors;
}

function githubSlug(heading) {
  return heading
    .replace(/`([^`]*)`/g, '$1')
    .replace(/<[^>]+>/g, '')
    .trim()
    .toLowerCase()
    .replace(/[^\p{Letter}\p{Number}\s-]/gu, '')
    .trim()
    .replace(/\s+/g, '-');
}

function between(text, startMarker, endMarker) {
  const start = text.indexOf(startMarker);
  if (start === -1) throw new Error(`${startMarker} not found`);
  const contentStart = start + startMarker.length;
  const end = text.indexOf(endMarker, contentStart);
  if (end === -1) throw new Error(`${endMarker} not found`);
  return text.slice(contentStart, end);
}

function runCli(args, options = {}) {
  return spawnSync(process.execPath, [bin, ...args], {
    cwd: packageRoot,
    encoding: 'utf8',
    env: options.env ? { ...process.env, ...options.env } : process.env,
    input: options.input ?? undefined,
  });
}

function assertEqual(actual, expected, label) {
  if (actual !== expected) throw new Error(`${label} mismatch\nexpected: ${format(expected)}\nactual:   ${format(actual)}`);
}

function assertIncludes(actual, expected, label) {
  if (!actual.includes(expected)) throw new Error(`${label} did not include ${format(expected)}\nactual: ${format(actual)}`);
}

function assertNotIncludes(actual, expected, label) {
  if (String(actual).includes(expected)) throw new Error(`${label} unexpectedly included ${format(expected)}\nactual: ${format(actual)}`);
}

function assertArrayEqual(actual, expected, label) {
  const actualText = actual.join('\n');
  const expectedText = expected.join('\n');
  if (actualText !== expectedText) {
    const onlyActual = actual.filter((item) => !expected.includes(item));
    const onlyExpected = expected.filter((item) => !actual.includes(item));
    throw new Error(`${label} mismatch\nonly actual: ${format(onlyActual)}\nonly expected: ${format(onlyExpected)}`);
  }
}

function format(value) {
  return typeof value === 'string' ? JSON.stringify(value) : String(value);
}

if (isMainModule(import.meta.url)) {
  const reporter = new TestReporter();
  try {
    runRegression(reporter);
    reporter.totalLine();
  } catch (_) {
    process.exit(1);
  }
}
