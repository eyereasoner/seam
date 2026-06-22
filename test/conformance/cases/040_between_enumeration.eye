% Reference 9.5: between/3 enumerates every integer in an inclusive range.
answer(n, ?x) :- between(3, 5, ?x).
materialize(answer, 2).
