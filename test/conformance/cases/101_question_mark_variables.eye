% Question-mark variables are ordinary variables, useful for N3/SPARQL-style source.
materialize(answer, 2).
edge(a, b).
edge(b, c).
path(?x, ?y) :- edge(?x, ?y).
path(?x, ?z) :- edge(?x, ?y), path(?y, ?z).
answer(?x, ?y) :- path(?x, ?y).
