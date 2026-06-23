% Reference 9.2, 9.3: arithmetic and comparison built-ins.
answer(sum, ?x) :- add(2, 3, ?x).
answer(diff, ?x) :- sub(7, 4, ?x).
answer(product, ?x) :- mul(6, 7, ?x).
answer(integer_division, ?x) :- div(7, 2, ?x).
answer(remainder, ?x) :- mod(7, 2, ?x).
answer(power, ?x) :- pow(2, 8, ?x).
answer(minimum, ?x) :- min(3, 9, ?x).
answer(less_than, true) :- lt(3, 9).
answer(greater_equal, true) :- ge(9, 9).
materialize(answer, 2).
