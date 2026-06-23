materialize(answer, 1).
seed(a).
p(?x) :- seed(?x), not(blocked(?x)).
blocked(?x) :- p(?x).
answer(ok).
