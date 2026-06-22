% Each `?_` occurrence is anonymous and independent.
materialize(answer, 1).
pair(a, b).
pair(c, d).
answer(left(?x)) :- pair(?x, ?_).
answer(right(?y)) :- pair(?_, ?y).
