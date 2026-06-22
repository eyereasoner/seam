materialize(answer, 1).
choice(a).
choice(b).
answer(?x) :- once(choice(?x)).
