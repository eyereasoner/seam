materialize(answer, 2).
answer(sum, ?x) :- sum_list([5, -2, 7], ?x).
answer(min, ?x) :- min_list([5, -2, 7], ?x).
answer(max, ?x) :- max_list([5, -2, 7], ?x).
