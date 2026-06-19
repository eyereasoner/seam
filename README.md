# Eyelang

[![npm version](https://img.shields.io/npm/v/eyelang.svg)](https://www.npmjs.com/package/eyelang)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.20761726-blue.svg)](https://doi.org/10.5281/zenodo.20761726)

Eyelang is a small logic programming language for rules, goals, answers, and proofs.
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

### Eyelang built-ins

The Eyelang engine has its own built-in registry under `src/builtins/`. Built-ins are called as ordinary Eyelang predicates. See the [Eyelang language reference](docs/language-reference.md#9-standard-built-in-predicates) for the portable profile. The bundled implementation currently registers 80 name/arity entries across 78 predicate names:

| Family | Count | Built-ins |
|---|---:|---|
| Core and host | 4 | `eq/2`, `neq/2`, `local_time/1`, `difference/3` |
| Arithmetic, comparison, and generators | 29 | `neg/2`, `abs/2`, `sin/2`, `cos/2`, `tan/2`, `asin/2`, `acos/2`, `sqrt/2`, `floor/2`, `ceiling/2`, `trunc/2`, `rounded/2`, `exp/2`, `log/2`, `add/3`, `sub/3`, `mul/3`, `div/3`, `mod/3`, `min/3`, `max/3`, `pow/3`, `atan2/3`, `lt/2`, `gt/2`, `le/2`, `ge/2`, `between/3`, `smallest_divisor_from/3` |
| Strings and conversions | 15 | `str_concat/3`, `contains/2`, `matches/2`, `matches/3`, `not_matches/2`, `split/3`, `join/3`, `substring/4`, `replace/4`, `lowercase/2`, `uppercase/2`, `trim/2`, `number_string/2`, `atom_string/2`, `term_string/2` |
| Lists | 19 | `append/3`, `nth0/3`, `set_nth0/4`, `head/2`, `rest/2`, `last/2`, `take/3`, `drop/3`, `slice/4`, `member/2`, `select/3`, `not_member/2`, `reverse/2`, `length/2`, `sum_list/2`, `min_list/2`, `max_list/2`, `list_to_set/2`, `sort/2` |
| Aggregation | 5 | `findall/3`, `countall/2`, `sumall/3`, `aggregate_min/5`, `aggregate_max/5` |
| Control | 3 | `not/1`, `once/1`, `forall/2` |
| Context and terms | 5 | `holds/2`, `holds/3`, `functor/3`, `arg/3`, `compound_name_arguments/3` |
| **Total** | **80** |  |


## Custom built-ins

Custom built-ins can be supplied by creating a `BuiltinRegistry` and passing it to the solver or `run` API.

## Tests

```bash
npm test
npm run test:conformance
npm run test:examples
npm run test:regression
```

