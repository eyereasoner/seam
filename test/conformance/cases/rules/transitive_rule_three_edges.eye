materialize(path, 2).
table(path, 2).
edge(a, b).
edge(b, c).
edge(c, d).
path(?x, ?y) :- edge(?x, ?y).
path(?x, ?z) :- edge(?x, ?y), path(?y, ?z).
