% Improper lists preserve their tail in read-back.
materialize(answer, 1).
seed([a, b | tail]).
answer(?x) :- seed(?x).
