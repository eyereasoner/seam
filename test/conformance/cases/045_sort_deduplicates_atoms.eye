% Reference 9.8: sort/2 sorts and deduplicates a proper list.
answer(sorted, ?x) :- sort([c, a, b, a], ?x).
materialize(answer, 2).
