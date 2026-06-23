% Reference 5.1, 7.1: repeated variables in a rule body require the same term.
pair(a, a).
pair(a, b).
pair(c, c).
diagonal(?x) :- pair(?x, ?x).
answer(diagonal, ?x) :- diagonal(?x).
materialize(answer, 2).
