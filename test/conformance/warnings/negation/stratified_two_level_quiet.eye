materialize(answer, 1).
base(a).
blocked(b).
allowed(?x) :- base(?x), not(blocked(?x)).
answer(?x) :- allowed(?x).
