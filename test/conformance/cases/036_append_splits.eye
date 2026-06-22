% Reference 9.7: append/3 can enumerate proper prefix/suffix splits.
answer(split, split(?a, ?b)) :- append(?a, ?b, [a, b]).
materialize(answer, 2).
