% Each `?` occurrence is anonymous and independent.
materialize(answer, 1).
pair(a, b).
pair(c, d).
answer(left(?x)) :- pair(?x, ?).
answer(right(?y)) :- pair(?, ?y).
