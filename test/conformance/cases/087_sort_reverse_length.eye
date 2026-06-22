% Reference 9.7 and 9.8: list ordering and length built-ins are deterministic on proper lists.
materialize(answer, 2).
answer(length_empty, ?x) :- length([], ?x).
answer(length_nested, ?x) :- length([[a], [b, c], []], ?x).
answer(reverse_atoms, ?x) :- reverse([a, b, c], ?x).
answer(sort_numbers, ?x) :- sort([3, 1, 2, 1], ?x).
answer(sort_mixed_terms, ?x) :- sort([b, 2, a, 1, pair(a), "s"], ?x).
answer(reverse_empty, ?x) :- reverse([], ?x).
