materialize(answer, 2).
table(path, 2).
edge(a, b).
edge(b, c).
path(?x, ?y) :- edge(?x, ?y).
path(?x, ?z) :- edge(?x, ?y), path(?y, ?z).
answer(table_path_bound, ?x) :- path(a, ?x).
