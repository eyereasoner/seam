% A lone graphic < remains a graphic atom, not an IRI opener.
materialize(answer, 1).
seed(<).
answer(?x) :- seed(?x).
