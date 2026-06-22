% `table/2` is a search-control declaration and does not change answers.
materialize(path, 2).
table(path, 2).
edge(a, b).
edge(b, c).
path(?x, ?y) :- edge(?x, ?y).
path(?x, ?z) :- edge(?x, ?y), path(?y, ?z).
