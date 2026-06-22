materialize(answer, 1).
item(a).
answer(?x) :- item(?x), not(missing(?x)).
