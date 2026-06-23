materialize(answer, 2).
item(a).
item(b).
answer(findall_builtin, ?bag) :- findall(?x, item(?x), ?bag).
