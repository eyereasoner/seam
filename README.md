# Eyelang

[![npm version](https://img.shields.io/npm/v/eyelang.svg)](https://www.npmjs.com/package/eyelang)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.20761726-blue.svg)](https://doi.org/10.5281/zenodo.20761726)

Eyelang is a small logic programming language for rules, goals, answers, and proofs.
Its source syntax is Prolog-like Horn-clause syntax with deliberate eyelang choices, including `?x` variables for N3/SPARQL-style readability, explicit `table(path, 2).` declarations for tabled predicates, advisory `mode/3` declarations for host tooling, and stratified-negation diagnostics for portable `not/1` usage.
It grew out of logic-language experiments in the EYE/N3 reasoning tradition, but is packaged here as its own project.

## Install and run

Eyelang has no runtime npm dependencies and no build step. From a source checkout, run the CLI directly with Node.js 18 or newer:

```bash
node bin/eyelang.js examples/ancestor.eye
node bin/eyelang.js --proof examples/socrates.eye
node bin/eyelang.js --warnings examples/policy.eye
printf 'works(stdin, true) :- eq(ok, ok).\n' | node bin/eyelang.js -
```

For one-off local CLI use from the checkout, npm can run the package bin without a manual symlink:

```bash
npm exec -- eyelang --version
npm exec -- eyelang examples/ancestor.eye
```

To install the checkout's `eyelang` command on your `PATH`, use npm's package link:

```bash
npm link
eyelang --version
```

## JavaScript API

```js
import { run, Program, Solver } from 'eyelang';

const result = run(`
materialize(answer, 1).
answer(ok) :- eq(ok, ok).
`);
console.log(result.stdout);
```

## Documentation

- [Playground](https://eyereasoner.github.io/eyelang/playground)
- [Guide](docs/guide.md)
- [Language reference](docs/language-reference.md)

For local browser use, serve the checkout first so the playground can load ES modules and example files:

```bash
python3 -m http.server
# then open http://localhost:8000/playground.html
```

## Tests

```bash
npm test
npm run test:conformance
npm run test:examples
npm run test:regression
```

