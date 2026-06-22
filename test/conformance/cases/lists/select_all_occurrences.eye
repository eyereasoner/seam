materialize(answer, 2).
answer(?item, ?rest) :- select(?item, [a, b, a], ?rest).
