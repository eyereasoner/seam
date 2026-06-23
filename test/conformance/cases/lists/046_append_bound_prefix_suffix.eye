% Reference 9.7: append/3 supports bound prefix and suffix use cases.
answer(prefix, ?x) :- append(?x, [c], [a, b, c]).
answer(suffix, ?x) :- append([a], ?x, [a, b, c]).
materialize(answer, 2).
