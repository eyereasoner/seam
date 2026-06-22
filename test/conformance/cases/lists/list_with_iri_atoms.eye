% Lists can contain IRI atoms directly.
materialize(answer, 1).
seed([<urn:example:a>, <urn:example:b>]).
answer(?x) :- seed(?x).
