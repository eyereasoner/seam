# Eyelang

[![npm version](https://img.shields.io/npm/v/eyelang.svg)](https://www.npmjs.com/package/eyelang)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.20761726-blue.svg)](https://doi.org/10.5281/zenodo.20761726)

Eyelang is a small logic programming language for rules, goals, answers, and proofs.
Its source syntax is a deliberately small subset of ordinary Prolog term and Horn-clause syntax.
It grew out of logic-language experiments in the EYE/N3 reasoning tradition, but is packaged here as its own project.

## Install and run

```bash
npm install
eyelang examples/ancestor.pl
eyelang --proof examples/socrates.pl
printf 'works(stdin, true) :- eq(ok, ok).
' | eyelang -
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

- [Guide](docs/guide.md)
- [Language reference](docs/language-reference.md)

## Tests

```bash
npm test
npm run test:conformance
npm run test:examples
npm run test:regression
```

