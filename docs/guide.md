# Eyelang Guide

This guide introduces Eyelang, a small Horn-clause language and engine whose source syntax is Prolog-like but deliberately its own compact language for rules, goals, answers, and proofs. Eyelang works over ordinary terms, lists, arithmetic, strings, and finite search. Run it with the `eyelang` CLI, or use `node bin/eyelang.js` when working directly from a source checkout.

Programs write relations directly, for example `ancestor(pat, emma)` or `status(case1, accepted)`. Eyelang output is ordinary Eyelang syntax: by default, the CLI materializes selected answer facts and prints those facts only. Pass `--proof` (or `-p`) when you also want each answer followed by a `why/2` explanation fact that records the proof. Programs may add `materialize/2` declarations such as `materialize(answer, 2).` to focus output on selected predicates.


For the normative language definition, including lexical syntax, terms, clauses, goals, built-ins, `table/2`, `materialize/2`, and conformance boundaries, read the [Eyelang language reference](language-reference.md).

## Contents

1. [Quick start](#quick-start)
2. [Running eyelang](#running-eyelang)
3. [Default output](#default-output)
4. [Writing programs](#writing-programs)
5. [Aggregation helpers](#aggregation-helpers)
6. [Context data](#context-data)
7. [Example catalog](#example-catalog)
8. [Golden outputs, tests, and conformance](#golden-outputs-tests-and-conformance)
9. [Development and release](#development-and-release)
10. [Relationship to Eyeling](#relationship-to-eyeling)
11. [Performance notes](#performance-notes)
12. [Implementation limits](#implementation-limits)

## Quick start

Eyelang has no runtime npm dependencies and no build step. From a source checkout, run the CLI entry point directly with Node.js 18 or newer:

```sh
node bin/eyelang.js --version
node bin/eyelang.js examples/ancestor.eye
node bin/eyelang.js facts.eye rules.eye
printf 'works(stdin, true) :- eq(ok, ok).\n' | node bin/eyelang.js -
```

You can also use npm's local package-bin runner from the checkout:

```sh
npm exec -- eyelang --version
npm exec -- eyelang examples/ancestor.eye
```

To make the `eyelang` command available on your `PATH` while developing this checkout, prefer npm's package link instead of a manual symlink:

```sh
npm link
eyelang --version
```

`npm install -g .` is another local-checkout option if you want npm to install the package globally instead of linking it. Avoid hand-written `/usr/local/bin` symlinks unless you really need one; npm already reads the `bin` entry in `package.json` and creates the correct executable shim.

## Running eyelang

The commands in this section use `eyelang` for readability. In a source checkout where you have not run `npm link` or `npm install -g .`, replace `eyelang` with `node bin/eyelang.js`, or run the command through `npm exec -- eyelang`.

Show the package version:

```sh
eyelang --version
eyelang -v
```

Run a program and let eyelang print derived binary facts:

```sh
eyelang examples/ancestor.eye
```

Enable proof explanations when you want machine-readable provenance:

```sh
eyelang --proof examples/ancestor.eye
eyelang -p examples/ancestor.eye
```

eyelang-readable explanations are opt-in proof output. Each `why/2` fact contains a nested abstract proof term, and a blank line separates consecutive explanations. Using eyelang syntax for explanations keeps them in the same language as the answers themselves: they are readable by humans, parseable by eyelang, easy to test, and can be transformed or explained further like any other eyelang data. For example:

```eyelang
type(socrates, mortal).
why(
  type(socrates, mortal),
  proof(
    goal(type(socrates, mortal)),
    by(rule("socrates.eye", clause(4))),
    bindings([binding("?x", socrates)]),
    uses([
      proof(
        goal(type(socrates, man)),
        by(fact("socrates.eye", clause(3)))
      )
    ])
  )
).

```

The explanation output can itself be read as eyelang input; for example, another program can materialize `why/2` facts such as `why(type(socrates, mortal), ?proof)`. `--proof` adds only these explanation facts; it does not change the answers found by the solver.

### Explanation cookbook

Eyelang answers can carry their own provenance when proof output is enabled.

Explain one derived fact:

```sh
eyelang --proof examples/socrates.eye
```

The output contains the answer and a `why/2` fact. The proof term shows the source rule that produced the answer and the source fact used below it. Source references use `rule("file.eye", clause(?n))` and `fact("file.eye", clause(?n))`, where `?n` is the 1-based clause number in that file.

Inspect variable bindings with a small policy program:

```eyelang
score(case1, 95).
threshold(90).

status(?case, accepted) :-
  score(?case, ?score),
  threshold(?t),
  ge(?score, ?t).
```

```sh
eyelang --proof policy.eye
```

The explanation contains the instantiated answer and the variables that made the rule succeed:

```eyelang
status(case1, accepted).
why(
  status(case1, accepted),
  proof(
    goal(status(case1, accepted)),
    by(rule("policy.eye", clause(3))),
    bindings([binding("?case", case1), binding("?score", 95), binding("?t", 90)]),
    uses([...])
  )
).
```

Use the `uses([...])` list to follow the proof tree. In the policy example it contains one subproof for `score(case1, 95)`, one for `threshold(90)`, and one for the built-in comparison `ge(95, 90)`. Built-ins are shown as `builtin(?name, ?arity)` because they do not come from source clauses.

Reuse explanations as data:

```sh
eyelang --proof examples/socrates.eye > socrates.why.eye
```

The resulting file is ordinary Eyelang syntax containing both answers and `why/2` proof facts.

Compose multiple files, stdin, and URLs:

```sh
eyelang facts.eye rules.eye
printf 'works(stdin, true) :- eq(ok, ok).\n' | eyelang -
eyelang https://example.test/program.eye
```

## Default output

Eyelang programs write relation predicates directly:

```eyelang
parent(pat, jan).
parent(jan, emma).

ancestor(?x, ?y) :- parent(?x, ?y).
ancestor(?x, ?z) :- parent(?x, ?y), ancestor(?y, ?z).
```

By default, eyelang asks for new ground consequences of selected output predicates, suppresses duplicates, excludes source facts, sorts the result, and prints Prolog facts:

```eyelang
ancestor(jan, emma).
ancestor(pat, emma).
ancestor(pat, jan).
```

This default is intentionally output-oriented. It is not a complete bottom-up saturation engine. Built-ins and proof search remain goal-directed; use `materialize/2` declarations and small output predicates when you want a specific relation, arity, or non-binary answer.

### Focusing default output

Large examples often have internal helper predicates. Add `materialize/2` declarations to restrict default output to selected predicates:

```eyelang
materialize(answer, 2).

seed(case1).
helper(?case, score(95)) :- seed(?case).
answer(?case, accepted) :- helper(?case, score(95)).
```

The default output is then:

```eyelang
answer(case1, accepted).
```

`materialize/2` is a declaration, not a logical rule to prove. It affects which predicates the CLI prints, not the meaning of the rules themselves. Materialized output facts are not inserted back into the running program for later goals; if later output predicates reuse the same derived helper relation, eyelang proves it again unless that helper is declared with `table/2`. Source facts are indexed and reused normally, and tabled solved goals are reused inside the same solver run.

## Writing programs

A good eyelang program normally has three layers:

1. source facts;
2. helper predicates for calculation or search;
3. concise relation-style outputs, usually binary predicates such as `status(?case, ?value)`, `reason(?case, ?text)`, `ancestor(?person, ?ancestor)`, or `cost(?path, ?amount)`.

Example:

```eyelang
score(case1, 95).
threshold(90).

accepted(?case) :-
  score(?case, ?score),
  threshold(?threshold),
  ge(?score, ?threshold).

status(?case, accepted) :- accepted(?case).
reason(?case, "score exceeds threshold") :- accepted(?case).
```

When `status/2` and `reason/2` are derived, they appear in default output. If the program has many helper binary predicates, declare the intended output predicates:

```eyelang
materialize(status, 2).
materialize(reason, 2).
```

### Naming

Predicate names and atom constants use the same lexical form. Namespace-like names should be plain names such as `type`, `person_name`, or `odrl_permission`; colon names are not part of the language.

### Embedding remains general

The CLI is output-oriented and uses `materialize/2` to decide what to print. Embedders can still use the JavaScript API and `Solver` directly for arbitrary goals and arities.

Add `-s` or `--stats` when you want lightweight solver counters on stderr without changing stdout:

```sh
eyelang -s examples/observability-log-correlation.eye
```

The playground has matching `--stats` and `--proof` checkboxes, so browser runs can show the same counters or explanations like the CLI.


### Builtins

Eyelang builtins are registered by name and arity in small modules under [`src/builtins`](../src/builtins). This keeps the runtime portable to Node.js and the browser while giving each builtin family a clear boundary. Built-ins are called as ordinary Eyelang predicates. See the [Eyelang language reference](language-reference.md#9-standard-built-in-predicates) for the portable profile. The bundled implementation currently registers 80 name/arity entries across 78 predicate names:

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


To add a builtin, create or extend a module with `register(registry)` and call `registry.add(name, arity, handler, options)`. The default registry is assembled in [`src/builtins/registry.js`](../src/builtins/registry.js). Builtins that are only safe for specific argument modes should provide a `ready` predicate and `fallbackWhenNotReady: true`, so user-defined clauses remain visible until the builtin is applicable.


## Aggregation helpers

Eyelang includes goal-directed aggregation helpers for finite searches:

```eyelang
countall(?goal, ?count).
sumall(?value, ?goal, ?sum).
aggregate_min(?key, ?template, ?goal, ?bestkey, ?besttemplate).
aggregate_max(?key, ?template, ?goal, ?bestkey, ?besttemplate).
```

Use `countall/2` for solution counts, `sumall/3` for numeric totals, and `aggregate_min/5` or `aggregate_max/5` when a search should keep only the best candidate instead of collecting and sorting every answer. The key can be a number, atom constant, string, compound term, or list; normal term ordering is used, so compound keys such as `[?cost, ?path]` are useful for deterministic tie-breaking.

Example:

```eyelang
best_cycle(?cycle, ?cost) :-
  cities(?cities),
  aggregate_min([?cost, ?cycle], ?cycle, candidate_cycle(?cities, ?cycle, ?cost), [?cost, ?cycle], ?cycle).
```

## Context data

Comma terms can be data as well as conjunctions. eyelang provides two context utilities:

```eyelang
holds((name(alice, "Alice"), knows(alice, bob)), name(?s, ?o)).
holds((ready, name(alice, "Alice"), route(alice, bob, 7)), ?name, ?args).
```

Use `holds/2` when you want to match the member term directly, for example `name(?s, ?o)`, `route(?a, ?b, ?cost)`, or `edge(?a, arc(?b, ?cost))`. Use `holds/3` when you need the predicate name and argument list as data: it exposes any-arity member as atom constant `?name` plus a proper list `?args`, so zero-, binary-, and ternary members appear as `ready/0`, `name/2`, and `route/3` shapes without a special binary predicate. These utilities are useful for quoted context data, but they do not make those context members true in the ambient program. The [`context-schema-audit.eye`](../examples/context-schema-audit.eye) example shows a case that really needs `holds/3`: it audits heterogeneous message contexts by extracting every member as `?name + ?args`, computing each arity, and checking the resulting shape against a schema without knowing the predicate names in advance.

`matches/3` can create context data from named regular-expression captures, which is useful when text logs or messages need to become facts before later rules inspect them with `holds/2` or `holds/3`. See [`observability-log-correlation.eye`](../examples/observability-log-correlation.eye) for a complete log-correlation example.


## Example catalog

| Example | Description | Golden output |
| --- | --- | --- |
| [`access-control-policy.eye`](../examples/access-control-policy.eye) | Evaluates role and condition based access decisions. | [`output/access-control-policy.eye`](../examples/output/access-control-policy.eye) |
| [`ackermann.eye`](../examples/ackermann.eye) | Computes Ackermann-style hyperoperation values. | [`output/ackermann.eye`](../examples/output/ackermann.eye) |
| [`age.eye`](../examples/age.eye) | Checks whether people meet age thresholds. | [`output/age.eye`](../examples/output/age.eye) |
| [`aliases-and-namespaces.eye`](../examples/aliases-and-namespaces.eye) | Shows ordinary predicate names for vocabulary aliases. | [`output/aliases-and-namespaces.eye`](../examples/output/aliases-and-namespaces.eye) |
| [`alignment-demo.eye`](../examples/alignment-demo.eye) | Rolls dataset concepts up through a small alignment taxonomy. | [`output/alignment-demo.eye`](../examples/output/alignment-demo.eye) |
| [`allen-interval-calculus.eye`](../examples/allen-interval-calculus.eye) | Classifies interval relations with integer time offsets. | [`output/allen-interval-calculus.eye`](../examples/output/allen-interval-calculus.eye) |
| [`ancestor.eye`](../examples/ancestor.eye) | Derives ancestors from parent facts. | [`output/ancestor.eye`](../examples/output/ancestor.eye) |
| [`animal.eye`](../examples/animal.eye) | Classifies animals from traits. | [`output/animal.eye`](../examples/output/animal.eye) |
| [`annotation.eye`](../examples/annotation.eye) | Derives facts from quoted annotation data. | [`output/annotation.eye`](../examples/output/annotation.eye) |
| [`auroracare.eye`](../examples/auroracare.eye) | Evaluates purpose-based medical data access scenarios. | [`output/auroracare.eye`](../examples/output/auroracare.eye) |
| [`backward.eye`](../examples/backward.eye) | Shows a backward-rule pattern as a goal-directed numeric rule. | [`output/backward.eye`](../examples/output/backward.eye) |
| [`basic-monadic.eye`](../examples/basic-monadic.eye) | Runs the basic monadic benchmark with explicit indexed edge joins instead of specialized search builtins. | [`output/basic-monadic.eye`](../examples/output/basic-monadic.eye) |
| [`bayes-diagnosis.eye`](../examples/bayes-diagnosis.eye) | Computes scaled Bayesian diagnosis posteriors. | [`output/bayes-diagnosis.eye`](../examples/output/bayes-diagnosis.eye) |
| [`bayes-therapy.eye`](../examples/bayes-therapy.eye) | Ranks therapies using Bayesian disease likelihoods. | [`output/bayes-therapy.eye`](../examples/output/bayes-therapy.eye) |
| [`beam-deflection.eye`](../examples/beam-deflection.eye) | Computes cantilever beam deflection. | [`output/beam-deflection.eye`](../examples/output/beam-deflection.eye) |
| [`binomial-vandermonde.eye`](../examples/binomial-vandermonde.eye) | Computes binomial coefficients and checks Vandermonde's identity. | [`output/binomial-vandermonde.eye`](../examples/output/binomial-vandermonde.eye) |
| [`blocks-world-planning.eye`](../examples/blocks-world-planning.eye) | Searches a finite blocks-world plan. | [`output/blocks-world-planning.eye`](../examples/output/blocks-world-planning.eye) |
| [`bmi.eye`](../examples/bmi.eye) | Normalizes BMI inputs and classifies weight. | [`output/bmi.eye`](../examples/output/bmi.eye) |
| [`braking-safety-worlds.eye`](../examples/braking-safety-worlds.eye) | Classifies braking safety under alternative worlds. | [`output/braking-safety-worlds.eye`](../examples/output/braking-safety-worlds.eye) |
| [`buck-converter-design.eye`](../examples/buck-converter-design.eye) | Checks buck-converter ripple design. | [`output/buck-converter-design.eye`](../examples/output/buck-converter-design.eye) |
| [`cache-performance.eye`](../examples/cache-performance.eye) | Summarizes cache latency performance. | [`output/cache-performance.eye`](../examples/output/cache-performance.eye) |
| [`canary-release.eye`](../examples/canary-release.eye) | Decides canary rollout or rollback. | [`output/canary-release.eye`](../examples/output/canary-release.eye) |
| [`cat-koko.eye`](../examples/cat-koko.eye) | Demonstrates named existential witnesses from a Cat Koko rule pattern. | [`output/cat-koko.eye`](../examples/output/cat-koko.eye) |
| [`catalan-convolution.eye`](../examples/catalan-convolution.eye) | Computes Catalan numbers by tabled convolution. | [`output/catalan-convolution.eye`](../examples/output/catalan-convolution.eye) |
| [`chart-parser.eye`](../examples/chart-parser.eye) | Parses small sentences with a tabled chart parser. | [`output/chart-parser.eye`](../examples/output/chart-parser.eye) |
| [`clinical-trial-screening.eye`](../examples/clinical-trial-screening.eye) | Screens candidates for a trial. | [`output/clinical-trial-screening.eye`](../examples/output/clinical-trial-screening.eye) |
| [`collatz-1000.eye`](../examples/collatz-1000.eye) | Materializes Collatz trajectories for starts 1000 down to 1. | [`output/collatz-1000.eye`](../examples/output/collatz-1000.eye) |
| [`combinatorics-findall-sort.eye`](../examples/combinatorics-findall-sort.eye) | Collects and sorts finite combinations. | [`output/combinatorics-findall-sort.eye`](../examples/output/combinatorics-findall-sort.eye) |
| [`competitive-enzyme-kinetics.eye`](../examples/competitive-enzyme-kinetics.eye) | Computes inhibited enzyme reaction rates. | [`output/competitive-enzyme-kinetics.eye`](../examples/output/competitive-enzyme-kinetics.eye) |
| [`complex.eye`](../examples/complex.eye) | Performs arithmetic on complex pairs. | [`output/complex.eye`](../examples/output/complex.eye) |
| [`composition-of-injective-functions-is-injective.eye`](../examples/composition-of-injective-functions-is-injective.eye) | Encodes composition and injectivity of finite functions. | [`output/composition-of-injective-functions-is-injective.eye`](../examples/output/composition-of-injective-functions-is-injective.eye) |
| [`context-association.eye`](../examples/context-association.eye) | Associates named contexts with their contents. | [`output/context-association.eye`](../examples/output/context-association.eye) |
| [`context-schema-audit.eye`](../examples/context-schema-audit.eye) | Audits mixed-arity context members with `holds/3`. | [`output/context-schema-audit.eye`](../examples/output/context-schema-audit.eye) |
| [`continued-fraction-sqrt2.eye`](../examples/continued-fraction-sqrt2.eye) | Computes sqrt(2) continued-fraction convergents and Pell errors. | [`output/continued-fraction-sqrt2.eye`](../examples/output/continued-fraction-sqrt2.eye) |
| [`control-system.eye`](../examples/control-system.eye) | Evaluates control-system measurements and targets. | [`output/control-system.eye`](../examples/output/control-system.eye) |
| [`critical-path-schedule.eye`](../examples/critical-path-schedule.eye) | Computes earliest starts and the critical path for a project network. | [`output/critical-path-schedule.eye`](../examples/output/critical-path-schedule.eye) |
| [`cyclic-path.eye`](../examples/cyclic-path.eye) | Computes paths in a cyclic graph. | [`output/cyclic-path.eye`](../examples/output/cyclic-path.eye) |
| [`d3-group.eye`](../examples/d3-group.eye) | Enumerates subgroups of the D3 group. | [`output/d3-group.eye`](../examples/output/d3-group.eye) |
| [`dairy-energy-balance.eye`](../examples/dairy-energy-balance.eye) | Classifies dairy cow energy balance. | [`output/dairy-energy-balance.eye`](../examples/output/dairy-energy-balance.eye) |
| [`data-negotiation.eye`](../examples/data-negotiation.eye) | Chooses an accepted data-negotiation offer. | [`output/data-negotiation.eye`](../examples/output/data-negotiation.eye) |
| [`deep-taxonomy-10.eye`](../examples/deep-taxonomy-10.eye) | Stress-tests recursive taxonomy depth 10. | [`output/deep-taxonomy-10.eye`](../examples/output/deep-taxonomy-10.eye) |
| [`deep-taxonomy-100.eye`](../examples/deep-taxonomy-100.eye) | Stress-tests recursive taxonomy depth 100. | [`output/deep-taxonomy-100.eye`](../examples/output/deep-taxonomy-100.eye) |
| [`deep-taxonomy-1000.eye`](../examples/deep-taxonomy-1000.eye) | Stress-tests recursive taxonomy depth 1000. | [`output/deep-taxonomy-1000.eye`](../examples/output/deep-taxonomy-1000.eye) |
| [`deep-taxonomy-10000.eye`](../examples/deep-taxonomy-10000.eye) | Stress-tests recursive taxonomy depth 10000. | [`output/deep-taxonomy-10000.eye`](../examples/output/deep-taxonomy-10000.eye) |
| [`deep-taxonomy-100000.eye`](../examples/deep-taxonomy-100000.eye) | Stress-tests recursive taxonomy depth 100000. | [`output/deep-taxonomy-100000.eye`](../examples/output/deep-taxonomy-100000.eye) |
| [`delfour.eye`](../examples/delfour.eye) | Derives shopping and authorization recommendations. | [`output/delfour.eye`](../examples/output/delfour.eye) |
| [`deontic-logic.eye`](../examples/deontic-logic.eye) | Reports obligations, prohibitions, and violations. | [`output/deontic-logic.eye`](../examples/output/deontic-logic.eye) |
| [`derived-backward-rule.eye`](../examples/derived-backward-rule.eye) | Derives an inverse-property backward rule from rule data. | [`output/derived-backward-rule.eye`](../examples/output/derived-backward-rule.eye) |
| [`derived-rule.eye`](../examples/derived-rule.eye) | Derives conclusions from rule data. | [`output/derived-rule.eye`](../examples/output/derived-rule.eye) |
| [`diamond-property.eye`](../examples/diamond-property.eye) | Checks the diamond property of a relation. | [`output/diamond-property.eye`](../examples/output/diamond-property.eye) |
| [`dijkstra.eye`](../examples/dijkstra.eye) | Enumerates weighted simple paths. | [`output/dijkstra.eye`](../examples/output/dijkstra.eye) |
| [`dijkstra-findall-sort.eye`](../examples/dijkstra-findall-sort.eye) | Finds shortest paths using collected candidates. | [`output/dijkstra-findall-sort.eye`](../examples/output/dijkstra-findall-sort.eye) |
| [`dijkstra-risk-path.eye`](../examples/dijkstra-risk-path.eye) | Ranks routes by cost and trust. | [`output/dijkstra-risk-path.eye`](../examples/output/dijkstra-risk-path.eye) |
| [`dining-philosophers.eye`](../examples/dining-philosophers.eye) | Simulates Chandy-Misra fork exchanges. | [`output/dining-philosophers.eye`](../examples/output/dining-philosophers.eye) |
| [`dog.eye`](../examples/dog.eye) | Counts dogs and derives when a license is required. | [`output/dog.eye`](../examples/output/dog.eye) |
| [`dpv-odrl-purpose-mapping.eye`](../examples/dpv-odrl-purpose-mapping.eye) | Maps a DPV process into an ODRL permission view. | [`output/dpv-odrl-purpose-mapping.eye`](../examples/output/dpv-odrl-purpose-mapping.eye) |
| [`drone-corridor-planner.eye`](../examples/drone-corridor-planner.eye) | Plans bounded drone corridor routes. | [`output/drone-corridor-planner.eye`](../examples/output/drone-corridor-planner.eye) |
| [`easter-computus.eye`](../examples/easter-computus.eye) | Computes Gregorian Easter dates. | [`output/easter-computus.eye`](../examples/output/easter-computus.eye) |
| [`electrical-rc-filter.eye`](../examples/electrical-rc-filter.eye) | Sizes an RC low-pass filter. | [`output/electrical-rc-filter.eye`](../examples/output/electrical-rc-filter.eye) |
| [`epidemic-policy.eye`](../examples/epidemic-policy.eye) | Chooses policies from risk and social cost. | [`output/epidemic-policy.eye`](../examples/output/epidemic-policy.eye) |
| [`equivalence-classes-overlap-implies-same-class.eye`](../examples/equivalence-classes-overlap-implies-same-class.eye) | Packages the shared-member proof pattern for equivalence classes. | [`output/equivalence-classes-overlap-implies-same-class.eye`](../examples/output/equivalence-classes-overlap-implies-same-class.eye) |
| [`eulerian-path.eye`](../examples/eulerian-path.eye) | Finds an Eulerian path using each edge once. | [`output/eulerian-path.eye`](../examples/output/eulerian-path.eye) |
| [`ev-range-worlds.eye`](../examples/ev-range-worlds.eye) | Estimates electric-vehicle trip feasibility. | [`output/ev-range-worlds.eye`](../examples/output/ev-range-worlds.eye) |
| [`existential-rule.eye`](../examples/existential-rule.eye) | Represents existential witnesses with explicit Skolem-style terms. | [`output/existential-rule.eye`](../examples/output/existential-rule.eye) |
| [`exoplanet-validation-worlds.eye`](../examples/exoplanet-validation-worlds.eye) | Validates exoplanet candidates across worlds. | [`output/exoplanet-validation-worlds.eye`](../examples/output/exoplanet-validation-worlds.eye) |
| [`expression-eval.eye`](../examples/expression-eval.eye) | Evaluates a small arithmetic expression tree. | [`output/expression-eval.eye`](../examples/output/expression-eval.eye) |
| [`family-cousins.eye`](../examples/family-cousins.eye) | Derives cousin and family labels. | [`output/family-cousins.eye`](../examples/output/family-cousins.eye) |
| [`fastpow.eye`](../examples/fastpow.eye) | Computes powers by repeated squaring. | [`output/fastpow.eye`](../examples/output/fastpow.eye) |
| [`fft8-numeric.eye`](../examples/fft8-numeric.eye) | Runs an 8-point FFT over complex pairs. | [`output/fft8-numeric.eye`](../examples/output/fft8-numeric.eye) |
| [`fibonacci.eye`](../examples/fibonacci.eye) | Computes large Fibonacci numbers by fast doubling. | [`output/fibonacci.eye`](../examples/output/fibonacci.eye) |
| [`field-nitrogen-balance.eye`](../examples/field-nitrogen-balance.eye) | Classifies field nitrogen balance. | [`output/field-nitrogen-balance.eye`](../examples/output/field-nitrogen-balance.eye) |
| [`flandor.eye`](../examples/flandor.eye) | Derives a Flanders macro-insight authorization and retooling package. | [`output/flandor.eye`](../examples/output/flandor.eye) |
| [`floating-point.eye`](../examples/floating-point.eye) | Exercises floating-point arithmetic and comparisons. | [`output/floating-point.eye`](../examples/output/floating-point.eye) |
| [`four-color-map.eye`](../examples/four-color-map.eye) | Checks a four-colour map assignment. | [`output/four-color-map.eye`](../examples/output/four-color-map.eye) |
| [`fundamental-theorem-arithmetic.eye`](../examples/fundamental-theorem-arithmetic.eye) | Factors integers and reconstructs products. | [`output/fundamental-theorem-arithmetic.eye`](../examples/output/fundamental-theorem-arithmetic.eye) |
| [`gd-step-certified.eye`](../examples/gd-step-certified.eye) | Certifies a gradient-descent step. | [`output/gd-step-certified.eye`](../examples/output/gd-step-certified.eye) |
| [`gdpr-compliance.eye`](../examples/gdpr-compliance.eye) | Checks GDPR-style processing compliance. | [`output/gdpr-compliance.eye`](../examples/output/gdpr-compliance.eye) |
| [`good-cobbler.eye`](../examples/good-cobbler.eye) | Demonstrates term-level structure with a good-cobbler statement. | [`output/good-cobbler.eye`](../examples/output/good-cobbler.eye) |
| [`gps.eye`](../examples/gps.eye) | Finds and verifies route paths. | [`output/gps.eye`](../examples/output/gps.eye) |
| [`graph.eye`](../examples/graph.eye) | Derives transitive paths over French-city road links while showing the productive recursive rule order. | [`output/graph.eye`](../examples/output/graph.eye) |
| [`graph-reachability.eye`](../examples/graph-reachability.eye) | Derives reachable nodes in a graph. | [`output/graph-reachability.eye`](../examples/output/graph-reachability.eye) |
| [`gray-code-counter.eye`](../examples/gray-code-counter.eye) | Generates Gray-code counter states. | [`output/gray-code-counter.eye`](../examples/output/gray-code-counter.eye) |
| [`greatest-lower-bound-uniqueness.eye`](../examples/greatest-lower-bound-uniqueness.eye) | Shows uniqueness of greatest lower bounds in a finite order instance. | [`output/greatest-lower-bound-uniqueness.eye`](../examples/output/greatest-lower-bound-uniqueness.eye) |
| [`group-inverse-uniqueness.eye`](../examples/group-inverse-uniqueness.eye) | Shows uniqueness of inverses in a finite group instance. | [`output/group-inverse-uniqueness.eye`](../examples/output/group-inverse-uniqueness.eye) |
| [`hamiltonian-path.eye`](../examples/hamiltonian-path.eye) | Finds a Hamiltonian path. | [`output/hamiltonian-path.eye`](../examples/output/hamiltonian-path.eye) |
| [`hamming-code.eye`](../examples/hamming-code.eye) | Corrects a single-bit Hamming word. | [`output/hamming-code.eye`](../examples/output/hamming-code.eye) |
| [`hanoi.eye`](../examples/hanoi.eye) | Derives the Towers of Hanoi moves. | [`output/hanoi.eye`](../examples/output/hanoi.eye) |
| [`heat-loss.eye`](../examples/heat-loss.eye) | Computes conductive heat loss. | [`output/heat-loss.eye`](../examples/output/heat-loss.eye) |
| [`heron-theorem.eye`](../examples/heron-theorem.eye) | Computes triangle area by Heron's theorem. | [`output/heron-theorem.eye`](../examples/output/heron-theorem.eye) |
| [`ideal-gas-law.eye`](../examples/ideal-gas-law.eye) | Applies the ideal gas law. | [`output/ideal-gas-law.eye`](../examples/output/ideal-gas-law.eye) |
| [`illegitimate-reasoning.eye`](../examples/illegitimate-reasoning.eye) | Detects suspect reasoning patterns. | [`output/illegitimate-reasoning.eye`](../examples/output/illegitimate-reasoning.eye) |
| [`integer-partitions.eye`](../examples/integer-partitions.eye) | Counts integer partitions with tabled dynamic programming. | [`output/integer-partitions.eye`](../examples/output/integer-partitions.eye) |
| [`intuitionistic-logic-kripke.eye`](../examples/intuitionistic-logic-kripke.eye) | Emulates intuitionistic Kripke forcing and constructive implication. | [`output/intuitionistic-logic-kripke.eye`](../examples/output/intuitionistic-logic-kripke.eye) |
| [`job-shop-scheduling.eye`](../examples/job-shop-scheduling.eye) | Searches a small job-shop schedule and minimizes makespan. | [`output/job-shop-scheduling.eye`](../examples/output/job-shop-scheduling.eye) |
| [`knapsack-optimization.eye`](../examples/knapsack-optimization.eye) | Optimizes a finite 0/1 knapsack pack with aggregation. | [`output/knapsack-optimization.eye`](../examples/output/knapsack-optimization.eye) |
| [`knowledge-engineering-alignment-flow.eye`](../examples/knowledge-engineering-alignment-flow.eye) | Specializes reusable alignment rules into a target-shaped flow view. | [`output/knowledge-engineering-alignment-flow.eye`](../examples/output/knowledge-engineering-alignment-flow.eye) |
| [`law-of-cosines.eye`](../examples/law-of-cosines.eye) | Computes a triangle side by cosine law. | [`output/law-of-cosines.eye`](../examples/output/law-of-cosines.eye) |
| [`least-squares-regression.eye`](../examples/least-squares-regression.eye) | Fits a least-squares regression line. | [`output/least-squares-regression.eye`](../examples/output/least-squares-regression.eye) |
| [`linear-logic-resources.eye`](../examples/linear-logic-resources.eye) | Emulates linear logic resource consumption with explicit state threading. | [`output/linear-logic-resources.eye`](../examples/output/linear-logic-resources.eye) |
| [`list-collection.eye`](../examples/list-collection.eye) | Demonstrates list and collection built-ins. | [`output/list-collection.eye`](../examples/output/list-collection.eye) |
| [`lldm.eye`](../examples/lldm.eye) | Calculates leg-length discrepancy measurements. | [`output/lldm.eye`](../examples/output/lldm.eye) |
| [`manufacturing-quality-control.eye`](../examples/manufacturing-quality-control.eye) | Evaluates process capability and quality. | [`output/manufacturing-quality-control.eye`](../examples/output/manufacturing-quality-control.eye) |
| [`matrix-chain-order.eye`](../examples/matrix-chain-order.eye) | Finds an optimal matrix-chain multiplication order. | [`output/matrix-chain-order.eye`](../examples/output/matrix-chain-order.eye) |
| [`microgrid-dispatch.eye`](../examples/microgrid-dispatch.eye) | Plans microgrid dispatch and reserve. | [`output/microgrid-dispatch.eye`](../examples/output/microgrid-dispatch.eye) |
| [`missionaries-cannibals.eye`](../examples/missionaries-cannibals.eye) | Solves the missionaries-and-cannibals river crossing puzzle. | [`output/missionaries-cannibals.eye`](../examples/output/missionaries-cannibals.eye) |
| [`modal-logic-kripke.eye`](../examples/modal-logic-kripke.eye) | Emulates modal box and diamond operators over a finite Kripke frame. | [`output/modal-logic-kripke.eye`](../examples/output/modal-logic-kripke.eye) |
| [`modular-exponentiation.eye`](../examples/modular-exponentiation.eye) | Computes modular powers by repeated squaring. | [`output/modular-exponentiation.eye`](../examples/output/modular-exponentiation.eye) |
| [`monkey-bananas.eye`](../examples/monkey-bananas.eye) | Solves the monkey-and-bananas puzzle. | [`output/monkey-bananas.eye`](../examples/output/monkey-bananas.eye) |
| [`n-queens-8.eye`](../examples/n-queens-8.eye) | Solves the 8-queens search problem with diagonal constraints. | [`output/n-queens-8.eye`](../examples/output/n-queens-8.eye) |
| [`network-sla.eye`](../examples/network-sla.eye) | Checks network path SLA compliance. | [`output/network-sla.eye`](../examples/output/network-sla.eye) |
| [`newton-raphson.eye`](../examples/newton-raphson.eye) | Finds roots by Newton-Raphson iteration. | [`output/newton-raphson.eye`](../examples/output/newton-raphson.eye) |
| [`nixon-diamond.eye`](../examples/nixon-diamond.eye) | Reports the classic Nixon-diamond conflict. | [`output/nixon-diamond.eye`](../examples/output/nixon-diamond.eye) |
| [`observability-log-correlation.eye`](../examples/observability-log-correlation.eye) | Extracts named regex captures from observability logs and correlates events by trace id. | [`output/observability-log-correlation.eye`](../examples/output/observability-log-correlation.eye) |
| [`odrl-dpv-fpv-trust-flow.eye`](../examples/odrl-dpv-fpv-trust-flow.eye) | Decides ODRL/DPV data flows with local FPV trust gates. | [`output/odrl-dpv-fpv-trust-flow.eye`](../examples/output/odrl-dpv-fpv-trust-flow.eye) |
| [`odrl-dpv-healthcare-risk-ranked.eye`](../examples/odrl-dpv-healthcare-risk-ranked.eye) | Ranks healthcare policy risks and mitigations. | [`output/odrl-dpv-healthcare-risk-ranked.eye`](../examples/output/odrl-dpv-healthcare-risk-ranked.eye) |
| [`odrl-dpv-risk-ranked.eye`](../examples/odrl-dpv-risk-ranked.eye) | Ranks data-policy risks and mitigations. | [`output/odrl-dpv-risk-ranked.eye`](../examples/output/odrl-dpv-risk-ranked.eye) |
| [`orbital-transfer-design.eye`](../examples/orbital-transfer-design.eye) | Designs a Hohmann orbital transfer. | [`output/orbital-transfer-design.eye`](../examples/output/orbital-transfer-design.eye) |
| [`path-discovery.eye`](../examples/path-discovery.eye) | Discovers bounded air-route paths. | [`output/path-discovery.eye`](../examples/output/path-discovery.eye) |
| [`peano-arithmetic.eye`](../examples/peano-arithmetic.eye) | Computes Peano addition, multiplication, and factorial. | [`output/peano-arithmetic.eye`](../examples/output/peano-arithmetic.eye) |
| [`peasant.eye`](../examples/peasant.eye) | Performs peasant multiplication and exponentiation. | [`output/peasant.eye`](../examples/output/peasant.eye) |
| [`pell-equation.eye`](../examples/pell-equation.eye) | Generates Pell-equation solutions by recurrence. | [`output/pell-equation.eye`](../examples/output/pell-equation.eye) |
| [`pendulum-period.eye`](../examples/pendulum-period.eye) | Computes simple pendulum periods. | [`output/pendulum-period.eye`](../examples/output/pendulum-period.eye) |
| [`polynomial.eye`](../examples/polynomial.eye) | Finds complex integer polynomial roots. | [`output/polynomial.eye`](../examples/output/polynomial.eye) |
| [`proof-contrapositive.eye`](../examples/proof-contrapositive.eye) | Models proof by contrapositive. | [`output/proof-contrapositive.eye`](../examples/output/proof-contrapositive.eye) |
| [`quadratic-formula.eye`](../examples/quadratic-formula.eye) | Solves sample quadratic equations. | [`output/quadratic-formula.eye`](../examples/output/quadratic-formula.eye) |
| [`radioactive-decay.eye`](../examples/radioactive-decay.eye) | Computes radioactive decay over time. | [`output/radioactive-decay.eye`](../examples/output/radioactive-decay.eye) |
| [`reusable-builtins.eye`](../examples/reusable-builtins.eye) | Tours reusable numeric, list, and string builtins. | [`output/reusable-builtins.eye`](../examples/output/reusable-builtins.eye) |
| [`riemann-hypothesis.eye`](../examples/riemann-hypothesis.eye) | Checks a finite catalogue of non-trivial zeta zeros against the Riemann-hypothesis condition. | [`output/riemann-hypothesis.eye`](../examples/output/riemann-hypothesis.eye) |
| [`security-incident-correlation.eye`](../examples/security-incident-correlation.eye) | Correlates security incidents across signals. | [`output/security-incident-correlation.eye`](../examples/output/security-incident-correlation.eye) |
| [`send-more-money.eye`](../examples/send-more-money.eye) | Solves the SEND + MORE = MONEY cryptarithm. | [`output/send-more-money.eye`](../examples/output/send-more-money.eye) |
| [`service-impact.eye`](../examples/service-impact.eye) | Analyzes service impact over cyclic dependencies. | [`output/service-impact.eye`](../examples/output/service-impact.eye) |
| [`sieve.eye`](../examples/sieve.eye) | Enumerates primes with a sieve-style program. | [`output/sieve.eye`](../examples/output/sieve.eye) |
| [`skolem-functions.eye`](../examples/skolem-functions.eye) | Generates deterministic functional terms. | [`output/skolem-functions.eye`](../examples/output/skolem-functions.eye) |
| [`socket-age.eye`](../examples/socket-age.eye) | Shows socket-declared age reasoning inputs and plugs. | [`output/socket-age.eye`](../examples/output/socket-age.eye) |
| [`socket-family.eye`](../examples/socket-family.eye) | Shows socket-declared family-source inputs and ancestry rules. | [`output/socket-family.eye`](../examples/output/socket-family.eye) |
| [`socrates.eye`](../examples/socrates.eye) | Derives that Socrates is mortal. | [`output/socrates.eye`](../examples/output/socrates.eye) |
| [`stable-marriage.eye`](../examples/stable-marriage.eye) | Finds stable matchings by excluding blocking pairs. | [`output/stable-marriage.eye`](../examples/output/stable-marriage.eye) |
| [`statistics-summary.eye`](../examples/statistics-summary.eye) | Computes population statistics for a sample. | [`output/statistics-summary.eye`](../examples/output/statistics-summary.eye) |
| [`stirling-bell-numbers.eye`](../examples/stirling-bell-numbers.eye) | Computes Stirling numbers and Bell numbers. | [`output/stirling-bell-numbers.eye`](../examples/output/stirling-bell-numbers.eye) |
| [`sudoku-4x4.eye`](../examples/sudoku-4x4.eye) | Solves a compact 4x4 Sudoku by finite constraint search. | [`output/sudoku-4x4.eye`](../examples/output/sudoku-4x4.eye) |
| [`superdense-coding.eye`](../examples/superdense-coding.eye) | Models superdense-coding bit transmission. | [`output/superdense-coding.eye`](../examples/output/superdense-coding.eye) |
| [`term-tools.eye`](../examples/term-tools.eye) | Inspects, builds, renders, and validates terms with reusable term/control builtins. | [`output/term-tools.eye`](../examples/output/term-tools.eye) |
| [`totient-summatory.eye`](../examples/totient-summatory.eye) | Computes Euler totients and their summatory function. | [`output/totient-summatory.eye`](../examples/output/totient-summatory.eye) |
| [`trust-flow-provenance-threshold.eye`](../examples/trust-flow-provenance-threshold.eye) | Classifies message trust from provenance confidence scores. | [`output/trust-flow-provenance-threshold.eye`](../examples/output/trust-flow-provenance-threshold.eye) |
| [`turing.eye`](../examples/turing.eye) | Simulates a binary-increment Turing machine. | [`output/turing.eye`](../examples/output/turing.eye) |
| [`vector-similarity.eye`](../examples/vector-similarity.eye) | Computes dot product, norm, and cosine similarity. | [`output/vector-similarity.eye`](../examples/output/vector-similarity.eye) |
| [`vulnerability-impact.eye`](../examples/vulnerability-impact.eye) | Analyzes vulnerable transitive dependencies and urgent patch impact. | [`output/vulnerability-impact.eye`](../examples/output/vulnerability-impact.eye) |
| [`web-names.eye`](../examples/web-names.eye) | Uses compact Prolog-like `web(?space, ?local)` terms as readable global identifiers and expands selected terms to URIs. | [`output/web-names.eye`](../examples/output/web-names.eye) |
| [`weighted-interval-scheduling.eye`](../examples/weighted-interval-scheduling.eye) | Selects the best non-overlapping weighted intervals with tabled dynamic programming. | [`output/weighted-interval-scheduling.eye`](../examples/output/weighted-interval-scheduling.eye) |
| [`witch.eye`](../examples/witch.eye) | Derives the classic “burn the witch” rule chain. | [`output/witch.eye`](../examples/output/witch.eye) |
| [`wolf-goat-cabbage.eye`](../examples/wolf-goat-cabbage.eye) | Solves the wolf-goat-cabbage river crossing. | [`output/wolf-goat-cabbage.eye`](../examples/output/wolf-goat-cabbage.eye) |
| [`zebra.eye`](../examples/zebra.eye) | Solves the zebra logic puzzle. | [`output/zebra.eye`](../examples/output/zebra.eye) |

## Golden outputs, tests, and conformance

Golden answer outputs live in [`examples/output`](../examples/output). `npm run test:eyelang` covers the eyelang integration check, conformance cases, regression checks, runnable examples, and proof-output examples. A curated proof-output suite for `.eye` examples lives in [`examples/proof`](../examples/proof). Example tests pin `local_time/1` to `2026-05-30` so date-dependent examples stay deterministic. Regenerate them after an intentional output or explanation change:

```sh
for f in examples/*.eye; do
  [ -e "$f" ] || continue
  b=$(basename "$f")
  EYELANG_LOCAL_TIME=2026-05-30 eyelang "$f" > "examples/output/$b"
done

for f in examples/proof/*.eye; do
  b=$(basename "$f")
  EYELANG_LOCAL_TIME=2026-05-30 eyelang --proof "examples/$b" > "examples/proof/$b"
done
```

Run the full eyelang suite:

```sh
npm run test:eyelang
```

The eyelang corpus runner runs in this order: Conformance, Regression/API/White-box, Examples. Each section prints its own subtotal, followed by a suite-specific grand total. The suite checks the conformance cases derived from the language reference, supplemental regression/API/white-box checks, and every runnable example against its golden output.

Run only one internal suite when you are iterating:

```sh
node test/run-conformance.mjs
node test/run-regression.mjs
node test/run-examples.mjs
```

The conformance suite lives in [`test/conformance/`](../test/conformance/) as one flat eyelang corpus. Each case is a small `.eye` program with an exact expected stdout `.eye` file, and some cases also include a goal file for testing the embeddable solver, so other implementations can reuse the same cases. The suite covers the standard language surface from the language reference, including reusable built-ins. The regression suite lives in [`test/run-regression.mjs`](../test/run-regression.mjs) and covers CLI regressions, the public JavaScript API, and white-box invariants for parser, unification, and indexing behavior.

## Development and release

Common commands:

```sh
npm run test:eyelang        # alias for npm test
npm test                    # full conformance, regression/API/white-box, examples, and proof examples
node test/run-conformance.mjs
node test/run-regression.mjs
node test/run-examples.mjs
eyelang --help
```

Useful profiling smoke test:

```sh
eyelang -s examples/observability-log-correlation.eye > /dev/null
```

For a release:

1. update `VERSION`;
2. update `README.md` and the language reference;
3. regenerate golden outputs if behavior changed;
4. run `npm run test:eyelang`;
5. publish the repository with the browser playground assets if publishing the playground. The playground includes controls equivalent to CLI `--stats` and `--proof`.

## Relationship to Eyeling

[Eyeling](https://github.com/eyereasoner/eyeling) and eyelang share the same goal of small, inspectable rule-based reasoning in JavaScript, but they make different language and implementation trade-offs.

Eyeling is the RDF/Notation3 member of the family. It reads N3-style triples, quoted formulas, forward rules written with `=>`, backward rules written with `<=`, RDF terms, RDF-JS data, and RDF-oriented streams. That makes it the better fit when data interchange with RDF/N3 tools is the main requirement.

Eyelang is the compact Prolog-style member of the family. It uses ordinary predicate syntax such as `parent(alice, bob).` and `ancestor(?x, ?z) :- parent(?x, ?y), ancestor(?y, ?z).` The core remains close to the Prolog tradition while deliberately staying smaller and more explicit than ISO Prolog. It is a good fit when the problem is naturally relational, goal-directed, finite, and does not need RDF graph interchange.

A useful rule of thumb:

| Use case | Prefer | Why |
| --- | --- | --- |
| RDF/N3 data, triples, prefixes, graph terms, RDF-JS, RDF message streams | Eyeling | The surface language and APIs are RDF/Notation3-native. |
| Compact relational rules over ordinary terms, lists, arithmetic, and finite search | eyelang | The syntax is shorter for non-RDF relation programs and output is ordinary facts. |
| Human-auditable derivations | Either | Both can emit proof explanations when requested. |
| Large generated Horn-clause workloads | eyelang | The engine specializes in predicate/arity indexing, scalar argument indexes, fast fact paths, and materialized output goals. |

On local smoke benchmarks, eyelang is substantially faster on large generated Horn-clause and recursion-heavy workloads. These numbers are 5-run medians with stdout redirected to `/dev/null`, using Node.js `v22.16.0`, eyelang from this checkout, and Eyeling package version `1.34.6` with its default output mode. The ratio is `Eyeling median / eyelang median`, so larger numbers mean eyelang was faster.

| Example | eyelang median | Eyeling median | Ratio |
| --- | ---: | ---: | ---: |
| `fundamental-theorem-arithmetic` | `0.16 sec` | `2.00 sec` | `12.66x` |
| `deep-taxonomy-100000` | `1.69 sec` | `4.72 sec` | `2.79x` |
| `path-discovery` | `0.53 sec` | `1.62 sec` | `3.07x` |
| `fibonacci` | `0.15 sec` | `5.76 sec` | `38.40x` |
| `collatz-1000` | `0.71 sec` | `6.99 sec` | `9.85x` |

Treat these as smoke comparisons rather than a formal benchmark: hardware, Node.js version, package version, CLI startup, and output mode all matter.

The projects are therefore complementary rather than replacements for each other: Eyeling optimizes for Semantic Web interoperability and N3 expressiveness; eyelang optimizes for a small standard-looking relational rule language and fast finite goal-directed execution.

## Performance notes

Use `-s` or `--stats` for a quick sanity check while optimizing solver changes. It prints counters such as `solve_goals_calls`, `unify_calls`, `deterministic_rule_expansions`, `candidate_lists_selected`, `clause_candidates_considered`, `clauses_tried`, `max_depth`, and `max_solver_call_depth` to stderr, leaving normal output stable for golden-file tests. The `max_solver_call_depth` counter is especially useful for browser regressions, where the VM call stack can be tighter than a command-line run.

eyelang hashes predicate groups by name and arity, then indexes clauses by scalar argument values. It also builds two-argument composite indexes for scalar pairs and probes those composite indexes without per-lookup heap allocation. This helps both large generated programs with many predicates and selective queries such as:

```eyelang
edge(g1, a, ?x).
path(a, ?y).
status(?case, accepted).
```

Ground facts use a fast path that avoids freshening and copying a rule body. Recursive-predicate detection uses an explicit work stack, which keeps large predicate chains safer in the browser. Recursive examples use an active-call variant guard to prevent common cyclic closures from looping. Selected predicates can be tabled with:

```eyelang
table(path, 2).
```


For large programs, keep helper predicates selective, bind arguments early, and declare focused output predicates with `materialize/2` when default output would otherwise solve broad helper goals.

## Implementation limits

Eyelang is intentionally smaller than ISO Prolog. It has no operators, zero-arity compound syntax, cut, modules, dynamic database updates, DCGs, or complete ISO library. Negation is negation-as-failure through `not/1`. Search is goal-directed and expected to be finite for the selected output goals. Output explanations are non-normative proof printouts and do not change answer semantics. 
