% Reference 9.7: zero-based indexing can enumerate and set elements without mutating the source list.
materialize(answer, 2).
answer(index_value, pair(?i, ?v)) :- nth0(?i, [red, green, blue], ?v).
answer(bound_index, ?x) :- nth0(1, [red, green, blue], ?x).
answer(set_first, ?x) :- set_nth0(0, [red, green], blue, ?x).
answer(set_last, ?x) :- set_nth0(2, [a, b, c], z, ?x).
answer(index_too_large_rejected, ok) :- not(nth0(3, [a, b, c], ?x)).
answer(set_too_large_rejected, ok) :- not(set_nth0(3, [a, b, c], z, ?x)).
