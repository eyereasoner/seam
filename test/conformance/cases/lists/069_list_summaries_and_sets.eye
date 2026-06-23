% Reference 9.1: list summaries accept mixed numeric values and stable duplicate removal.
materialize(answer, 2).
answer(sum_empty, ?x) :- sum_list([], ?x).
answer(sum_mixed, ?x) :- sum_list([1, 2.5, 3], ?x).
answer(min_atom_order, ?x) :- min_list([delta, beta, gamma], ?x).
answer(max_atom_order, ?x) :- max_list([delta, beta, gamma], ?x).
answer(set_terms, ?x) :- list_to_set([pair(a, 1), pair(a, 1), pair(b, 2), pair(a, 1)], ?x).
answer(min_empty_rejected, ok) :- not(min_list([], ?x)).
answer(max_empty_rejected, ok) :- not(max_list([], ?x)).
