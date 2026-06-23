% Reference 9.7: relational list predicates compose and preserve enumeration order.
materialize(answer, 2).
answer(split, pair(?a, ?b)) :- append(?a, ?b, [x, y, z]).
answer(select_middle, ?rest) :- select(y, [x, y, z], ?rest).
answer(select_duplicate, pair(?value, ?rest)) :- select(?value, [a, b, a], ?rest).
answer(rebuild, ?whole) :- append([a, b], [c, d], ?whole).
answer(no_select_rejected, ok) :- not(select(z, [a, b], ?rest)).
