% Reference 9.7: select/3 enumerates removals of matching occurrences.
answer(rest, ?x) :- select(a, [a, b, a], ?x).
materialize(answer, 2).
