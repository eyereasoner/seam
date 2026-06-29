# Seam

[![npm version](https://img.shields.io/npm/v/seam.svg)](https://www.npmjs.com/package/seam)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.20761726-blue.svg)](https://doi.org/10.5281/zenodo.20761726)

Seam is a small logic programming language for facts, rules, goals, answers, and proofs.
Its source syntax is Prolog-like Horn-clause syntax with deliberate seam choices, including ISO Prolog-style `X` variables, explicit `table(path, 2).` declarations for tabled predicates, advisory `mode/3` declarations for host tooling, explicit Herbrand witness terms for executable existential-style consequences, and stratified-negation diagnostics for portable `not/1` usage.
It grew out of logic-language experiments in the EYE/N3 reasoning tradition, but is packaged here as its own project.

## Install and run

Seam has no runtime npm dependencies and no build step. From a source checkout, run the CLI directly with Node.js 18 or newer:

```bash
node bin/seam.js examples/ancestor.pl
node bin/seam.js --proof examples/socrates.pl
node bin/seam.js --warnings examples/policy.pl
printf 'works(stdin, true) :- eq(ok, ok).\n' | node bin/seam.js -
```

For one-off local CLI use from the checkout, npm can run the package bin without a manual symlink:

```bash
npm exec -- seam --version
npm exec -- seam examples/ancestor.pl
```

To install the checkout's `seam` command on your `PATH`, use npm's package link:

```bash
npm link
seam --version
```

## JavaScript API

```js
import { run, Program, Solver } from 'seam';

const result = run(`
materialize(answer, 1).
answer(ok) :- eq(ok, ok).
`);
console.log(result.stdout);
```

## Documentation

- [Playground](https://eyereasoner.github.io/seam/playground)
- [Guide](docs/guide.md)
- [Language reference](docs/language-reference.md)
- [A Compact Reasoning Workbench](docs/compact-reasoning-workbench.md)

For local browser use, serve the checkout first so the playground can load ES modules and example files:

```bash
python3 -m http.server
# then open http://localhost:8000/playground.html
```

## Tests

```bash
npm test
npm run test:conformance
npm run conformance:report
# release preparation writes conformance-report.md via the preversion script
npm run test:examples
npm run test:regression
```

