% Reference 5.3, 7.1: unification follows nested compound term structure.
fact(pair(a, nested(b, [c, d]))).
answer(middle, ?x) :- fact(pair(a, nested(?x, [c, d]))).
answer(list_tail, ?t) :- fact(pair(a, nested(b, [c | ?t]))).
materialize(answer, 2).
