materialize(answer, 2).
parent(alice, bob).
parent(bob, clara).
answer(?x, ?z) :- parent(?x, ?y), parent(?y, ?z).
