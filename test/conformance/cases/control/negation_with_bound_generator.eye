materialize(answer, 1).
item(a).
item(b).
blocked(b).
answer(?x) :- item(?x), not(blocked(?x)).
