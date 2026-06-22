% Reference 9.7: list summaries accept numbers and reject non-numeric sums.
materialize(answer, 2).
answer(sum_integers, ?x) :- sum_list([1, 2, 3, 4], ?x).
answer(sum_decimals, ?x) :- sum_list([1.5, 2.25, -0.75], ?x).
answer(min_terms, ?x) :- min_list([pair(b), pair(a), pair(c)], ?x).
answer(max_terms, ?x) :- max_list([pair(b), pair(a), pair(c)], ?x).
answer(sum_non_number_rejected, ok) :- not(sum_list([1, a], ?x)).
answer(set_scalars, ?x) :- list_to_set([b, a, b, 1, 1, "a", a], ?x).
