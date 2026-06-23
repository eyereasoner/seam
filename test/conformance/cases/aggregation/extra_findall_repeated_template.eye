materialize(answer, 2).
item(a).
item(b).
answer(findall_repeated_template, ?bag) :- findall(pair(?x, ?x), item(?x), ?bag).
