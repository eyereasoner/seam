% Reference 5.4, 7.3, 9.7: recursive path construction can carry list evidence.
materialize(answer, 2).
edge(a, b).
edge(b, c).
edge(c, d).
path(?x, ?y, [?x, ?y]) :- edge(?x, ?y).
path(?x, ?z, [?x | ?rest]) :- edge(?x, ?y), path(?y, ?z, ?rest).
answer(path, ?p) :- path(a, d, ?p).
answer(prefix, ?p) :- path(a, d, ?full), take(2, ?full, ?p).
answer(suffix, ?s) :- path(a, d, ?full), drop(2, ?full, ?s).
