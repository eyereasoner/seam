% Reference 9.7: set_nth0/4 updates zero-based positions functionally.
answer(first, ?x) :- set_nth0(0, [a, b, c], x, ?x).
answer(last, ?x) :- set_nth0(2, [a, b, c], z, ?x).
materialize(answer, 2).
