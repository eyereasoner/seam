% Reusing a variable name in separate clauses does not connect the clauses.
materialize(answer, 1).
left(a).
right(b).
answer(?x) :- left(?x).
answer(?x) :- right(?x).
