% Built-ins use one native spelling each, while vocabulary-style predicate names
% remain ordinary user predicates.
%
% This keeps the language small: add/3, lt/2, matches/3, and rest/2 are native
% operations, but labels such as nativeMath or vocabularyExample are just data.
materialize(value, 2).
materialize(ok, 2).
materialize(tail, 2).
materialize(label, 2).

% The first four rules call native built-ins; the last two rules show that
% application vocabulary is modeled with ordinary facts and rules.
value(nativeMath, ?x) :- add(0.125, 0.875, ?x).
ok(nativeCompare, true) :- lt(2, 3).
ok(nativeString, true) :- matches("scoped retail insight", "retail|medical").
tail(nativeList, ?tail) :- rest([a, b, c], ?tail).

% These names are just user data; eyelang does not give them special meaning.
example_label(vocabularyExample, "vocabulary names are ordinary predicate names").
label(vocabularyExample, ?text) :- example_label(vocabularyExample, ?text).
