materialize(answer, 1).
p(?x) :- q(?x), not(r(?x)).
q(a).
r(?x) :- p(?x).
answer(ok).
