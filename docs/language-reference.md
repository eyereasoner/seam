# Eyelang Language Reference

## Table of contents

- [Abstract](#abstract)
- [1. Terminology and normative language](#1-terminology-and-normative-language)
- [2. Design goals](#2-design-goals)
- [3. Lexical structure](#3-lexical-structure)
  - [3.1 Character stream](#31-character-stream)
  - [3.2 Comments](#32-comments)
  - [3.3 Punctuation tokens](#33-punctuation-tokens)
  - [3.4 Variables](#34-variables)
  - [3.5 Atom constants](#35-atom-constants)
  - [3.6 Strings](#36-strings)
  - [3.7 Numbers](#37-numbers)
- [4. Surface grammar](#4-surface-grammar)
- [5. Terms](#5-terms)
  - [5.1 Variables](#51-variables)
  - [5.2 Atom constants, strings, and numbers](#52-atom-constants-strings-and-numbers)
  - [5.3 Compound terms and atomic formulas](#53-compound-terms-and-atomic-formulas)
  - [5.4 Lists](#54-lists)
  - [5.5 Comma terms](#55-comma-terms)
- [6. Clauses and predicates](#6-clauses-and-predicates)
- [7. Goals and proof search](#7-goals-and-proof-search)
  - [7.1 Unification](#71-unification)
  - [7.2 Failure](#72-failure)
  - [7.3 Finite search expectation](#73-finite-search-expectation)
- [8. Logical reading: Herbrand semantics](#8-logical-reading-herbrand-semantics)
  - [8.1 Variables and quantification](#81-variables-and-quantification)
  - [8.2 Equality, identity, and unification](#82-equality-identity-and-unification)
  - [8.3 Goal-directed execution versus model-theoretic meaning](#83-goal-directed-execution-versus-model-theoretic-meaning)
  - [8.4 Built-ins and operational extensions](#84-built-ins-and-operational-extensions)
- [9. Standard built-in predicates](#9-standard-built-in-predicates)
  - [9.1 Equality and unification](#91-equality-and-unification)
  - [9.2 Arithmetic](#92-arithmetic)
  - [9.3 Comparison](#93-comparison)
  - [9.4 Dates and durations](#94-dates-and-durations)
  - [9.5 Generators](#95-generators)
  - [9.6 Strings and atom constants](#96-strings-and-atom-constants)
  - [9.7 Lists](#97-lists)
  - [9.8 Aggregation and ordering](#98-aggregation-and-ordering)
  - [9.9 Context and term inspection](#99-context-and-term-inspection)
  - [9.10 Search control](#910-search-control)
- [10. Implementation-specific built-ins](#10-implementation-specific-built-ins)
- [11. Declarations](#11-declarations)
  - [11.1 Tabling](#111-tabling)
  - [11.2 Default-output materialization](#112-default-output-materialization)
- [12. eyelang Sockets](#12-eyelang-sockets)
  - [12.1 Socket vocabulary](#121-socket-vocabulary)
  - [12.2 Socket example](#122-socket-example)
  - [12.3 Sockets and AI agents](#123-sockets-and-ai-agents)
- [13. Output and read-back profile](#13-output-and-read-back-profile)
  - [13.1 Explanation output](#131-explanation-output)
- [14. Conformance](#14-conformance)
- [15. Relationship to ISO Prolog](#15-relationship-to-iso-prolog)
- [16. Examples](#16-examples)
  - [16.1 Transitive closure](#161-transitive-closure)
  - [16.2 Arithmetic](#162-arithmetic)
  - [16.3 Lists](#163-lists)
  - [16.4 Negation as failure](#164-negation-as-failure)
- [17. Security and portability considerations](#17-security-and-portability-considerations)

## Abstract

Eyelang is a compact definite-clause language whose surface syntax is Prolog-like term and clause syntax with deliberate eyelang choices for rule-based programs over ordinary terms, lists, arithmetic, strings, and finite search. A Eyelang program is a finite sequence of facts and Horn clauses. The underlying declarative semantics of the pure language is **Herbrand semantics**: constants, compound terms, and lists denote themselves, and predicates denote sets of ground atomic formulas over those terms. Evaluation is goal-directed: goals are solved by unification against facts, rules, and a fixed set of built-in predicates.

Eyelang is intentionally smaller than ISO Prolog. It supports compact Horn-clause reasoning, list processing, arithmetic examples, finite search, and context data, without operators, cut, modules, dynamic predicates, DCGs, zero-arity compound syntax, or a complete ISO standard library.

## 1. Terminology and normative language

The key words **MUST**, **MUST NOT**, **SHOULD**, **SHOULD NOT**, and **MAY** are to be interpreted as normative requirements.

A **term** is a variable, atom constant, string, number, list, or compound term.

An **atom constant** is a symbolic scalar term, such as `pat`, `type`, or `'atom with spaces'`. It is a term and may appear as an argument, list element, functor name, or predicate name.

An **atomic formula** is a predicate application such as `parent(pat, jan)` or `status(case1, accepted)`. It is the unit of truth in a Herbrand interpretation. In some logic-programming literature atomic formulas are called "atoms"; this specification avoids that shorthand. Whenever the noun "atom" appears here outside the phrase "atomic formula", it means **atom constant**.

This distinction is normative: `pat` is an atom constant and can appear as a term argument; `parent(pat, jan)` is an atomic formula and can appear as a fact, rule head, or goal. A compound term such as `pair(pat, jan)` has the same surface shape as an atomic formula, but its role is determined by context: as data it is a compound term, and as a clause head or goal it is an atomic formula with predicate symbol `pair/2`.

A **clause** is either a fact such as `parent(pat, jan).` or a rule such as `ancestor(?x, ?y) :- parent(?x, ?y).`.

A **goal** is an atomic formula, a built-in call, or a comma conjunction.

A **source fact** is a fact written directly in the input program. A **new derivation** is a ground consequence found through at least one rule and not merely repeated from the source facts.

The **Herbrand universe** of a program is the set of all ground eyelang terms constructible from the constants and functors in the program, together with the built-in list constructors `[]` and `./2` where lists are used. The **Herbrand base** is the set of all ground atomic formulas whose predicate symbols occur in the program and whose arguments are terms from the Herbrand universe.

## 2. Design goals

Eyelang is designed to be:

- small enough to embed and audit;
- deterministic in textual output order after duplicate suppression;
- useful for relation-style `p(?s, ?o)` output through ordinary predicate names;
- practical for examples involving recursion, lists, arithmetic, strings, aggregation, finite search, and context-valued data.

Non-goals include complete ISO Prolog compatibility, operator declarations, module systems, dynamic database updates, cut-based control, and full bottom-up closure semantics.

## 3. Lexical structure

### 3.1 Character stream

Input is Unicode text. Whitespace separates tokens and is otherwise insignificant outside quoted strings and quoted atom constants.

### 3.2 Comments

A percent sign starts a line comment outside quoted strings and quoted atom constants. The comment extends to the end of the line.

```eyelang
parent(pat, jan).  % this is a comment
```

### 3.3 Punctuation tokens

The punctuation tokens are:

```text
(  )  [  ]  ,  |  .  :-
```

A colon outside `:-` is not part of the language. Namespace-like names SHOULD be written as explicit atom constants such as `person_type`, `odrl_permission`, or quoted atoms such as `'org.schema'`.

### 3.4 Variables

A variable starts with `?` followed by an ASCII letter or underscore and then zero or more ASCII letters, digits, or underscores. This N3/SPARQL-style spelling is the only source-level variable spelling in eyelang.

Examples:

```eyelang
?x
?person
?_thing
?_
```

Each `?_` anonymous variable occurrence is fresh. A bare `_` is not a variable in eyelang source.

### 3.5 Atom constants

A plain atom constant starts with a lowercase ASCII letter and is followed by zero or more ASCII letters, digits, or underscores. A dot is not part of a plain atom; dotted web spaces such as `'be.ugent'` or `'org.schema'` MUST be quoted if they are meant as one atom constant. Names such as `a-b` MUST also be quoted if they are meant as one atom constant:

```eyelang
pat
type
case_123
'be.ugent'
'org.schema'
'eyereasoner.github'
'a-b'
```

Absolute IRI atom constants MAY also be written between angle brackets. The content must be an absolute IRI-like lexical value with a scheme such as `https:` or `urn:`. Eyelang stores the content as the atom value and prints absolute IRI atoms with angle brackets on read-back:

```eyelang
<https://example.org/alice>
<urn:example:bob>
triple(<https://example.org/alice>, <https://schema.org/name>, "Alice").
```

Quoted absolute IRI atoms remain valid input, but read-back normalizes them to angle-bracket syntax. For example, `'https://example.org/alice'` prints as `<https://example.org/alice>`.

A quoted atom constant is enclosed in single quotes. A single quote inside a quoted atom constant is represented by doubling it:

```eyelang
'atom with spaces'
'needs''quote'
''
```

A graphic atom constant is one or more graphic characters from this set:

```text
#$&*+-/<=>?@^~\
```

Angle-bracket IRI syntax is recognized only for absolute IRI-like contents. Graphic atoms such as `<=>`, `<`, and `>=` remain graphic atoms.

### 3.6 Strings

A string is enclosed in double quotes. The implementation supports common escapes such as `\n`, `\t`, `\"`, and `\\`.

### 3.7 Numbers

Numbers are scalar terms. Integers, decimal numbers, and scientific notation are accepted:

```eyelang
0
-42
0.25
1.25e-3
1.25e+3
```

Integer arithmetic built-ins use arbitrary-precision decimal strings where possible. Floating operations use the host implementation's IEEE-754 double-precision behavior.

## 4. Surface grammar

This grammar is descriptive. Implementations MAY reject programs that exceed implementation limits.

```text
program      ::= clause*
clause       ::= term "." | term ":-" goal_list "."
goal_list    ::= term ("," term)*
term         ::= variable
              | atom_constant
              | string
              | number
              | atom_constant "(" term ("," term)* ")"
              | "[" [list_items] "]"
              | "(" term ("," term)+ ")"
list_items   ::= term ("," term)* ["|" term]
```

Here `atom_constant` is a lexical class for symbolic scalar terms, not an atomic formula. Atomic formulas are represented by the grammar alternative `atom_constant "(" ... ")"` when such a compound appears in a clause head, rule body, or selected goal. Compound syntax always has at least one argument.

A clause head SHOULD be a compound term. Non-compound heads are parsed but are not useful in the current predicate index.

Arity-zero data is written as an atom constant, not as a zero-arity compound:

```eyelang
value(example, nil).
```

The syntax `nil()` is intentionally rejected so eyelang source and read-back output use one representation for arity-zero data.

## 5. Terms

### 5.1 Variables

Variables are scoped to a single clause or selected goal. A variable in a rule head and body denotes the same logical variable within that clause. Names preserve their spelling, so repeated `?x` occurrences in one clause refer to the same variable.

### 5.2 Atom constants, strings, and numbers

Atom constants, strings, and numbers are distinct scalar term kinds. Two scalar terms unify only when their type and lexical value match, except where a built-in explicitly interprets lexical values.

### 5.3 Compound terms and atomic formulas

A compound term has a functor name and arity:

```eyelang
parent(pat, jan)
pair(3, nested(atom, [x, y]))
```

The same concrete syntax is used for atomic formulas when the compound appears as a fact, rule head, or goal. In `parent(pat, jan).`, `parent/2` is a predicate symbol and the whole expression is an atomic formula. In `value(x, parent(pat, jan)).`, the inner `parent(pat, jan)` is ordinary compound data.

The functor or predicate name is fixed syntactically and is written as an atom constant. eyelang does not support variables in predicate or functor position.

### 5.4 Lists

Lists use Prolog surface syntax and are represented internally with `./2` and `[]`:

```eyelang
[]
[a, b, c]
[a, b | tail]
```

### 5.5 Comma terms

Parenthesized comma terms may be goals or data:

```eyelang
(parent(pat, jan), parent(jan, emma))
(name(alice, "Alice"), knows(alice, bob))
```

When a comma term appears as a goal, it is evaluated as conjunction. When it appears as data, it remains a term. `holds/2` enumerates member terms inside such contexts, and `holds/3` exposes each member as a predicate name plus an argument list for any arity.

## 6. Clauses and predicates

A fact has no body:

```eyelang
parent(pat, jan).
```

A rule has a head and a body:

```eyelang
ancestor(?x, ?y) :-
  parent(?x, ?y).

ancestor(?x, ?z) :-
  parent(?x, ?y),
  ancestor(?y, ?z).
```

Clauses with the same predicate name and arity define one predicate group. Predicate name and arity are both significant: `p/1` and `p/2` are different predicates.

## 7. Goals and proof search

Goals are solved left-to-right. For a user-defined atomic-formula goal, eyelang selects candidate clauses by predicate name, arity, and available indexes. A candidate clause is freshened, its head is unified with the goal, and then its body is solved.

A conjunction goal succeeds when all conjunct goals succeed in order. An answer is printed as the resolved answer term followed by a period.

### 7.1 Unification

Unification follows the ordinary first-order term structure used by the language. The implementation does not perform an occurs check.

### 7.2 Failure

A goal fails when no built-in case or user clause can prove it. eyelang has no exception term language; parse errors and resource failures are implementation errors reported to the host.

### 7.3 Finite search expectation

Programs and selected output goals SHOULD be written so the relevant search space is finite. eyelang includes recursion guards and tabling support, but it is not required to terminate for arbitrary recursive logic programs.

## 8. Logical reading: Herbrand semantics

The pure Eyelang language is interpreted over the **Herbrand universe** and **Herbrand base**. The Herbrand universe is the first-order universe made only of the ground terms that can be built from the program's atom constants, strings, numbers, list constructors, and compound functors. There are no hidden domain elements: a term denotes itself. For example, the atom constant `pat` denotes the Herbrand constant `pat`, and the number `3` denotes the numeric Herbrand constant written `3`. The Herbrand base is separate from the universe: it contains ground atomic formulas such as `parent(pat, jan)`, whose predicate symbol is `parent/2` and whose arguments are Herbrand terms.

An atom constant by itself is not true or false. For example, `pat` is a term, not a proposition. Truth applies to atomic formulas: `person(pat)` may be true or false in a Herbrand interpretation, while `pat` is simply one possible argument term.

A **Herbrand interpretation** for a program is a set of ground atomic formulas that are considered true. A source fact such as:

```eyelang
parent(pat, jan).
```

places the ground atomic formula `parent(pat, jan)` in the interpretation. A rule such as:

```eyelang
ancestor(?x, ?z) :- parent(?x, ?y), ancestor(?y, ?z).
```

is read universally over Herbrand terms: for every substitution of `?x`, `?y`, and `?z` by ground Herbrand terms, if both ground body atomic formulas are true, then the ground head atomic formula is true. The declarative meaning of a pure program is the **least Herbrand model**: the smallest set of ground atomic formulas that contains all facts and is closed under all rules.

Equivalently, the least Herbrand model is obtained by repeatedly applying the immediate-consequence operation: start with the source facts, add every ground rule head whose ground body is already true, and continue to the least fixed point. This definition is mathematical; an implementation does not have to compute the model bottom-up.

### 8.1 Variables and quantification

Variables do not range over external objects, records, pointers, or host-language values. In the logical reading, variables range over Herbrand terms. A rule is implicitly universally quantified over its variables. A selected goal is existential in the usual logic-programming sense: eyelang searches for substitutions of its variables by Herbrand terms that make the goal true with respect to the program.

### 8.2 Equality, identity, and unification

Because the domain is Herbrand, equality in the pure language is syntactic identity of terms after substitution. Two distinct atom constants are distinct. Two compound terms are equal only when they have the same functor, the same arity, and pairwise equal arguments. Lists follow the same rule through their `[]` and `./2` representation.

Operationally, eyelang uses first-order unification to find substitutions. The implementation does not perform an occurs check, so cyclic terms are not part of the portable Herbrand reading even if a particular implementation can temporarily construct recursive bindings internally. Portable programs SHOULD avoid relying on occurs-check-sensitive cases such as `eq(?x, f(?x))`.

### 8.3 Goal-directed execution versus model-theoretic meaning

eyelang's CLI and library evaluator are goal-directed. They try to prove requested goals by resolving them against facts, rules, and built-ins, using clause order, goal order, indexing, tabling, and deterministic built-in execution. This operational strategy is intended to enumerate answers that are true in the least Herbrand model for the pure Horn-clause fragment, but it is not a complete bottom-up model enumerator. Non-terminating recursion or infinite generators can prevent an answer from being found even when the answer belongs to the least Herbrand model.

Default CLI output is also a host behavior, not a separate semantics. It asks broad materialization goals, suppresses duplicates, excludes source facts, keeps ground answers, and prints selected consequences. Embedders can still access the goal-directed solver directly through the implementation API.

### 8.4 Built-ins and operational extensions

Built-ins are specified relations or operations added to the Herbrand core. A built-in call in a goal has the syntax of an atomic formula, but its success relation is specified procedurally here rather than by source clauses. Some built-ins, such as `eq/2`, `append/3`, `member/2`, and `length/2`, can be understood as relations over Herbrand terms. Others, such as arithmetic, string matching, date/time predicates, aggregation, `once/1`, and negation-as-failure, are operational extensions whose behavior is defined by this specification rather than by pure least-Herbrand-model semantics alone.

Arithmetic and string built-ins do not introduce a separate semantic universe. They inspect the lexical values of already represented Herbrand constants and, when they succeed, bind output arguments to eyelang terms such as numbers, strings, or atom constants. For example, `add(2, 3, ?x)` may bind `?x` to the number term `5`; it does not mean that variables range over host-language numbers outside the Herbrand universe.

Negation-as-failure `not(?goal)` is especially operational: it succeeds when the current goal-directed search finds no solution for `?goal`. It is not classical negation and should not be read as adding negative facts to the Herbrand model. Programs using negation SHOULD keep the negated goal sufficiently ground and finite.

## 9. Standard built-in predicates

This section specifies the **standard built-ins** of the Eyelang language. An implementation that claims support for this standard built-in profile MUST implement the predicates in this section with the meanings described here.

A built-in call is still written as an atomic formula, but the relation is provided by the host implementation rather than by source clauses. Several built-ins are mode-sensitive: they are intended to run when their input arguments are sufficiently ground, and implementations may leave user-defined clauses visible when that mode is not yet satisfied.

Implementations MAY provide additional built-ins, but such built-ins are implementation-specific and are not part of this normative catalog. Implementation-specific built-ins are discussed separately in section 10.

### 9.1 Equality and unification

| Built-in | Meaning |
|---|---|
| `eq(?a, ?b)` | Succeeds when `?a` and `?b` unify. |
| `neq(?a, ?b)` | Succeeds when `?a` and `?b` do not unify. |

### 9.2 Arithmetic

| Built-in | Meaning |
|---|---|
| `neg(?a, ?b)` | `?b` is the numeric negation of `?a`. |
| `abs(?a, ?b)` | `?b` is the absolute value of `?a`. |
| `sin(?a, ?b)`, `cos(?a, ?b)`, `tan(?a, ?b)` | Trigonometric floating functions. |
| `asin(?a, ?b)`, `acos(?a, ?b)`, `atan2(?y, ?x, ?angle)` | Inverse trigonometric floating functions. |
| `sqrt(?a, ?b)` | Square root. Fails for negative inputs. |
| `floor(?a, ?b)`, `ceiling(?a, ?b)`, `trunc(?a, ?b)`, `rounded(?a, ?b)` | Integer-valued numeric rounding functions. |
| `exp(?a, ?b)`, `log(?a, ?b)` | Natural exponent and logarithm. `log/2` fails for non-positive inputs. |
| `add(?a, ?b, ?c)` | `?c = ?a + ?b`. |
| `sub(?a, ?b, ?c)` | `?c = ?a - ?b`. |
| `mul(?a, ?b, ?c)` | `?c = ?a * ?b`. |
| `div(?a, ?b, ?c)` | `?c = ?a / ?b`; integer inputs use integer division. |
| `mod(?a, ?b, ?c)` | Integer remainder. |
| `pow(?a, ?b, ?c)` | `?c = ?a^?b`. |
| `min(?a, ?b, ?c)`, `max(?a, ?b, ?c)` | Numeric minimum and maximum. |

### 9.3 Comparison

| Built-in | Meaning |
|---|---|
| `lt(?a, ?b)` | `?a < ?b`. |
| `gt(?a, ?b)` | `?a > ?b`. |
| `le(?a, ?b)` | `?a =< ?b`. |
| `ge(?a, ?b)` | `?a >= ?b`. |

Comparisons interpret numeric-looking terms numerically. Other scalar terms are compared lexically.

### 9.4 Dates and durations

| Built-in | Meaning |
|---|---|
| `local_time(?t)` | Binds `?t` to the local date string. For deterministic runs, `EYELANG_LOCAL_TIME=YYYY-MM-DD` overrides the current date. |
| `difference(?a, ?b, ?d)` | Computes an ISO-like date/duration difference. |

### 9.5 Generators

| Built-in | Meaning |
|---|---|
| `between(?low, ?high, ?x)` | Enumerates integers from `?low` through `?high`. |
| `smallest_divisor_from(?n, ?start, ?d)` | Finds a divisor of `?n` starting at `?start`. |

### 9.6 Strings and atom constants

| Built-in | Meaning |
|---|---|
| `str_concat(?a, ?b, ?c)` | String concatenation. |
| `contains(?text, ?needle)` | `?text` contains `?needle`. |
| `matches(?text, ?pattern)` | Text matches a simple implementation regex/search pattern. |
| `matches(?text, ?pattern, ?context)` | `?text` matches a JavaScript regular expression with named capture groups; `?context` is a comma context containing one unary term per matched capture group. |
| `not_matches(?text, ?pattern)` | Negation of `matches/2`. |
| `split(?text, ?separator, ?parts)` | Splits text into a proper list of strings. |
| `join(?parts, ?separator, ?text)` | Joins a proper list of scalar terms into a string. |
| `substring(?text, ?start, ?length, ?out)` | Extracts a zero-based substring. |
| `replace(?text, ?search, ?replacement, ?out)` | Replaces all non-empty literal occurrences of `?search`. |
| `lowercase(?text, ?out)`, `uppercase(?text, ?out)`, `trim(?text, ?out)` | Text normalization helpers. |
| `number_string(?number, ?string)` | Converts a number to a string or parses a numeric string into a number. |
| `atom_string(?atom, ?string)` | Converts between atom constants and strings. |
| `term_string(?term, ?string)` | Renders a ground term as its eyelang source string. |

### 9.7 Lists

| Built-in | Meaning |
|---|---|
| `append(?a, ?b, ?c)` | List append/split relation. |
| `nth0(?index, ?list, ?value)` | Zero-based list lookup. |
| `set_nth0(?index, ?list, ?value, ?out)` | Functional list update. |
| `head(?list, ?head)` | Head of a non-empty list. |
| `rest(?list, ?tail)` | Tail of a non-empty list. |
| `last(?list, ?last)` | Last element of a non-empty proper list. |
| `take(?n, ?list, ?prefix)` | First `?n` items of a proper list. |
| `drop(?n, ?list, ?suffix)` | Proper-list suffix after dropping `?n` items. |
| `slice(?start, ?length, ?list, ?slice)` | Zero-based proper-list slice. |
| `member(?x, ?list)` | Member generator. |
| `select(?x, ?list, ?rest)` | Selects one occurrence. |
| `not_member(?x, ?list)` | Succeeds when `?x` is not a member. |
| `reverse(?a, ?b)` | Reverses a proper list. |
| `length(?list, ?n)` | Proper-list length. |
| `sum_list(?list, ?sum)` | Numeric sum of a proper list; empty lists produce `0`. |
| `min_list(?list, ?min)`, `max_list(?list, ?max)` | Minimum and maximum under standard term ordering. |
| `list_to_set(?list, ?set)` | Removes duplicates while preserving the first occurrence order. |
| `sort(?input, ?output)` | Sorts and deduplicates a proper list. |

### 9.8 Aggregation and ordering

| Built-in | Meaning |
|---|---|
| `findall(?template, ?goal, ?bag)` | Collects all templates for solutions of `?goal`. |
| `countall(?goal, ?count)` | Counts solutions of `?goal`; empty solution sets produce `0`. |
| `sumall(?template, ?goal, ?sum)` | Sums numeric `?template` values over solutions of `?goal`; empty solution sets produce `0`. |
| `aggregate_min(?key, ?template, ?goal, ?bestkey, ?besttemplate)` | Selects the solution of `?goal` with the smallest resolved `?key`, returning that key and the corresponding resolved `?template`. Fails when `?goal` has no solutions. |
| `aggregate_max(?key, ?template, ?goal, ?bestkey, ?besttemplate)` | Selects the solution of `?goal` with the largest resolved `?key`, returning that key and the corresponding resolved `?template`. Fails when `?goal` has no solutions. |

### 9.9 Context and term inspection

Context terms are data representations of atomic formulas and comma conjunctions.

| Built-in | Meaning |
|---|---|
| `holds(?context, ?term)` | Enumerates member terms inside a context term and unifies each member with `?term`. |
| `holds(?context, ?name, ?args)` | Enumerates context members of any arity, exposing each member as atom constant `?name` plus a proper argument list `?args`. |
| `functor(?term, ?name, ?arity)` | Decomposes a non-variable term into its name and arity. |
| `arg(?index, ?term, ?arg)` | Extracts the 1-based argument of a compound term. |
| `compound_name_arguments(?term, ?name, ?args)` | Decomposes a compound term or constructs one from an atom name and proper argument list. |

Example:

```eyelang
holds((name(alice, "Alice"), knows(alice, bob)), name(?s, ?o)).
holds((ready, name(alice, "Alice"), route(alice, bob, 7)), ?name, ?args).
functor(route(alice, bob, 7), route, 3).
arg(2, route(alice, bob, 7), bob).
compound_name_arguments(?term, route, [alice, bob, 7]).
```

The first goal can yield `holds((name(alice, "Alice"), knows(alice, bob)), name(alice, "Alice")).` The second can yield `holds((ready, name(alice, "Alice"), route(alice, bob, 7)), ready, []).`, `holds((ready, name(alice, "Alice"), route(alice, bob, 7)), name, [alice, "Alice"]).`, and `holds((ready, name(alice, "Alice"), route(alice, bob, 7)), route, [alice, bob, 7]).`

`holds/3` is the appropriate form for schema-style introspection because it exposes the predicate name and all arguments without assuming a fixed arity. For example, a single rule can inspect `heartbeat`, `source(sensor17)`, `temperature(sensor17, 38)`, and `signature(sensor17, sha256, ?hash, ?time)` as `heartbeat/0`, `source/1`, `temperature/2`, and `signature/4`; see [`context-schema-audit.eye`](../examples/context-schema-audit.eye).

### 9.10 Search control

| Built-in | Meaning |
|---|---|
| `not(?goal)` | Negation as failure. Succeeds when `?goal` has no solution. |
| `once(?goal)` | Succeeds with at most the first solution of `?goal`. |
| `forall(?generator, ?test)` | Succeeds when every solution of `?generator` also satisfies `?test`; succeeds vacuously when `?generator` has no solutions. |

## 10. Implementation-specific built-ins

Implementations MAY provide additional built-ins beyond the standard predicates listed above. Such built-ins are **implementation-specific built-ins**. They are useful for embedding eyelang in particular host environments, exposing efficient finite-domain solvers, or providing domain-specific relations for applications.

Implementation-specific built-ins are not required for conformance to this specification. A portable eyelang program SHOULD NOT depend on one unless the target implementation explicitly documents it.

An implementation-specific built-in SHOULD obey the same surface-language discipline as standard built-ins:

- it is called using ordinary atomic-formula syntax, for example `some_extension(?a, ?b)`;
- its arguments and results are eyelang terms from the Herbrand universe;
- it succeeds, fails, and binds variables as a relation over eyelang terms;
- it SHOULD document its intended modes, especially which arguments must be ground before it runs deterministically;
- it MUST NOT change the meaning of ordinary facts, rules, unification, or standard built-ins.

For example, an implementation may include host-specific integrations or domain accelerators. Those modules may be valuable and may make applications much faster, but their predicate names, arities, algorithms, and modes are implementation-defined unless they are separately standardized.

An implementation that provides explanation output SHOULD make implementation-specific built-ins explainable at least as opaque successful or failed built-in calls, so that proof traces do not incorrectly report "no clauses" for a host-provided relation.

## 11. Declarations

Declarations are written as ordinary facts, but the host treats them specially.

### 11.1 Tabling

```eyelang
table(path, 2).
```

The first argument MUST be an atom constant and the second argument MUST be a non-negative integer. A `table/2` declaration asks the solver to table answers for the named predicate group when applicable. The old `memoize/2` spelling is not part of the eyelang language.

Example:

```eyelang
table(path, 2).
```

### 11.2 Default-output materialization

```eyelang
materialize(answer, 2).
```

The first argument MUST be an atom constant and the second argument MUST be a non-negative integer. If a program contains one or more `materialize/2` declarations, default CLI output is restricted to those predicate groups. Source facts are still excluded from printed output.

Example:

```eyelang
materialize(status, 2).
materialize(reason, 2).
```

`materialize/2` affects host output selection only; it does not change the logical meaning of the program. Materialized output facts are not asserted as new source facts for subsequent output goals. A host MAY solve several materialized predicates in one solver run, and tabled predicate answers MAY be reused within that run, but this reuse is controlled by `table/2`, not by materialization.

### 11.3 Advisory modes and determinism

```eyelang
mode(path, 2, [in, out]).
det(root, 1).
semidet(edge, 2).
```

`mode/3`, `det/2`, and `semidet/2` are advisory declarations. They describe a predicate group's intended calling pattern and determinism, but they do not change proof search or answer output. Because they are ordinary facts, programs may also query them.

For `mode(?name, ?arity, ?modes)`, the first argument MUST be an atom constant naming the predicate, the second argument MUST be a non-negative integer arity, and the third argument MUST be a proper list whose length is equal to the arity. Portable mode atoms are:

- `in`: the argument is expected to be supplied by the caller;
- `out`: the argument is expected to be produced by the predicate;
- `any`: no portable mode commitment is made for that argument.

`det(?name, ?arity)` declares that a predicate is intended to produce exactly one answer for calls in its documented modes. `semidet(?name, ?arity)` declares that a predicate is intended to produce zero or one answer. This specification does not require runtime enforcement; hosts MAY use these declarations for linting, documentation, indexing decisions, or editor support.

Example:

```eyelang
mode(member, 2, [out, in]).
semidet(member, 2).
```

The example documents the common checking/generation mode where the list is supplied and the member is enumerated. A future linting host could warn if a program calls `member/2` outside that intended mode, but a conforming solver still treats `mode/3` and `semidet/2` as ordinary facts plus metadata.

## 12. Eyelang Sockets

A **eyelang Socket** is a declared semantic opening in a eyelang program where facts, rules, tools, datasets, or agents can plug in knowledge through an explicit contract while preserving eyelang-readable reasoning and explanations.

The term follows the ordinary socket pattern: a socket defines a place where a matching provider can connect. In eyelang, the matching part is knowledge. A socket identifies what shape of knowledge a program expects; a plug identifies which provider supplies it. This separates reasoning logic from knowledge providers and makes composition boundaries visible as eyelang data.

In this specification, sockets are a portable **programming pattern** expressed with ordinary facts. The core solver does not give `socket/2`, `plug/2`, `provides/1`, or `requires/1` special proof-search behavior unless a host explicitly documents such an extension. Because they are ordinary facts, socket declarations remain readable, inspectable, explainable, and safe to ignore by hosts that do not validate them.

### 12.1 Socket vocabulary

The minimal socket vocabulary is:

```eyelang
socket(?name, ?contract).
plug(?provider, ?name).
provides(?signature).
requires(?signature).
```

`?name` and `?provider` are ordinary eyelang terms, usually atom constants. `?contract` is an ordinary eyelang term that describes the expected or offered knowledge. A portable signature form is:

```eyelang
predicate(?predicatename, ?arity)
```

For example:

```eyelang
socket(family_source, provides(predicate(parent, 2))).
plug(family_file, family_source).
```

This says that `family_source` is a named opening for knowledge of the shape `parent/2`, and that `family_file` is the provider plugged into that opening.

### 12.2 Socket example

A rule module can declare the knowledge it expects:

```eyelang
materialize(ancestor, 2).

socket(family_source, provides(predicate(parent, 2))).
plug(family_file, family_source).

parent(pat, jan).
parent(jan, emma).

ancestor(?x, ?y) :-
    parent(?x, ?y).

ancestor(?x, ?z) :-
    parent(?x, ?y),
    ancestor(?y, ?z).
```

The `ancestor/2` rules do not depend on a particular storage mechanism for `parent/2`. In a small test, the provider may be the same file. In an embedded host, it may be a database adapter, a document extractor, a remote service, or another eyelang module. The socket facts make that boundary explicit without changing the logical meaning of the rules.

When eyelang derives `ancestor(pat, emma)`, the answer explanation can still refer to the source clauses that were actually used, for example facts for `parent/2` and rules for `ancestor/2`. The socket facts add an inspectable description of where such knowledge is intended to enter.

### 12.3 Sockets and AI agents

eyelang Sockets are especially useful for AI-facing systems. An AI agent can extract or propose candidate claims, but those claims should enter a reasoning program as explicit eyelang facts or rules through a declared socket rather than as opaque text. eyelang can then check the claims against other facts and rules, derive consequences, and optionally return ordinary `why/2` explanations.

This gives a clear division of labor: AI can help generate, translate, and connect knowledge; eyelang can represent, check, and explain the reasoning; sockets define the boundary between them.

## 13. Output and read-back profile

Normal answer output prints one resolved answer term followed by a period. Strings are double-quoted; atom constants are quoted when needed; lists use list syntax; compound terms use functor notation. Host interfaces MAY provide an option such as `--proof` to add `why/2` explanation facts; this option MUST NOT change the answers found.

Output SHOULD be accepted as eyelang input when it contains only supported term syntax. Explanations are ordinary eyelang facts, so answer output can be read back and processed by eyelang.

Default host output behavior is:

1. parse all inputs into one program;
2. collect source fact lines for duplicate suppression;
3. if `materialize/2` declarations exist, solve those predicate groups; otherwise solve all binary predicate groups with at least one rule;
4. keep only ground answers;
5. remove answers identical to source facts;
6. suppress duplicates;
7. print each answer, followed by its `why/2` explanation only if the host interface was explicitly asked to emit proof output.

### 13.1 Explanation output

When proof output is enabled, each answer SHOULD be followed by a machine-readable `why/2` fact. Explanation output is ordinary eyelang syntax whose second argument is a nested abstract proof term such as `proof(goal(?g), by(?method), bindings(?bindings), uses(?proofs))`; implementations SHOULD print `goal(...)` and `by(...)` on separate lines for readability. A proof term preserves the answer goal, derivation method, relevant bindings, and nested uses while omitting proof IDs. User clauses SHOULD be referenced explicitly as `fact(?filename, clause(?n))` or `rule(?filename, clause(?n))`, where `?n` is the 1-based clause number within that source. Built-ins SHOULD be referenced as `builtin(?name, ?arity)` because they do not come from source clauses. Explanation output is outside the logical semantics of the input program and MUST NOT change the set of answers.

## 14. Conformance

A conforming eyelang implementation supports the standard language described above as one conformance surface rather than as separate core and extension profiles. This includes:

- lexical syntax described above;
- facts and definite clauses;
- first-order unification without occurs check;
- left-to-right goal-directed proof search;
- lists and comma conjunctions;
- answer printing and read-back formatting;
- the standard built-ins listed in section 9;
- `table/2` declarations;
- `materialize/2` declarations;
- advisory `mode/3`, `det/2`, and `semidet/2` declarations;
- default derived output;
- explanation output when the host exposes proof output.

Browser execution, package layout, CLI URL loading, and any implementation-specific built-ins described in host documentation are outside this conformance surface unless separately standardized.

Conformance cases live in the repository under `test/conformance/`. They are run by `npm test` before the example suite, and can be run alone with `node test/run-conformance.mjs`. Each case has an input program under `conformance/cases/` and an exact expected standard-output file under `conformance/expected/`; both use `.eye` so expected output remains eyelang-readable.

## 15. Relationship to ISO Prolog

eyelang source is intended to be familiar to Prolog readers, but eyelang is not ISO Prolog and intentionally avoids some ISO-compatible source spellings. Notable differences include:

- `?x` variables are the only variable spelling; traditional Prolog `X` and `_` variables are rejected;
- no operators or operator declarations;
- no zero-arity compound syntax such as `nil()`;
- no cut;
- no modules;
- no dynamic database update;
- no DCGs;
- no full ISO term ordering or standard library;
- no variables in functor or predicate position;
- no occurs check in unification.

Programs intended to be portable to eyelang SHOULD use `?` variables, avoid ISO-specific syntax, and keep terms explicit. Atom names that are not plain lowercase-starting names, graphic atom tokens, or angle-bracket absolute IRI atoms SHOULD be written as quoted atoms, for example `'a-b'`.

## 16. Examples

### 16.1 Transitive closure

```eyelang
parent(pat, jan).
parent(jan, emma).

ancestor(?x, ?y) :- parent(?x, ?y).
ancestor(?x, ?z) :- parent(?x, ?y), ancestor(?y, ?z).
```

### 16.2 Arithmetic

```eyelang
square(?x, ?y) :- mul(?x, ?x, ?y).
answer(three, ?y) :- square(3, ?y).
```

### 16.3 Lists

```eyelang
first([?x | ?_rest], ?x).
answer(example, ?x) :- first([a, b, c], ?x).
```

### 16.4 Negation as failure

```eyelang
closed(b).
open(?x) :- not(closed(?x)).
status(a, open) :- open(a).
```

## 17. Security and portability considerations

URL input uses host networking support when available. Hosts SHOULD treat downloaded programs as untrusted code because they can trigger expensive search.

Programs SHOULD be written with finite search in mind. Broad default materialization can be expensive for helper predicates; use `materialize/2` declarations and concise output predicates when needed.

