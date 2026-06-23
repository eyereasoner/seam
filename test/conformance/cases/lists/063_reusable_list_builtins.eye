% Reference 9.1: reusable list selectors, slices, summaries, and stable set conversion.
materialize(answer, 2).
answer(head, ?x) :- head([alpha, beta, gamma, beta], ?x).
answer(last, ?x) :- last([alpha, beta, gamma, beta], ?x).
answer(take, ?x) :- take(2, [alpha, beta, gamma, beta], ?x).
answer(drop, ?x) :- drop(2, [alpha, beta, gamma, beta], ?x).
answer(slice, ?x) :- slice(1, 2, [alpha, beta, gamma, beta], ?x).
answer(sum, ?x) :- sum_list([1, 2, 3.5], ?x).
answer(min, ?x) :- min_list([3, 1, 2], ?x).
answer(max, ?x) :- max_list([3, 1, 2], ?x).
answer(set, ?x) :- list_to_set([beta, alpha, beta, gamma, alpha], ?x).
