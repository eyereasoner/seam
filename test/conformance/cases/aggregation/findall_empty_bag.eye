materialize(answer, 1).
answer(?bag) :- findall(?x, missing(?x), ?bag).
