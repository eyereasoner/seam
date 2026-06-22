materialize(answer, 1).
item(a).
item(b).
good(a).
answer(ok) :- not(forall(item(?x), good(?x))).
