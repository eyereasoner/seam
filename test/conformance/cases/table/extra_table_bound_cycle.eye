materialize(reach, 2).
table(path, 2).
edge(a, b).
edge(b, a).
path(?x, ?y) :- edge(?x, ?y).
path(?x, ?z) :- edge(?x, ?y), path(?y, ?z).
reach(a, ?x) :- path(a, ?x).
