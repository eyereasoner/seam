% The empty list is a first-class term.
materialize(answer, 1).
seed([]).
answer(?x) :- seed(?x).
