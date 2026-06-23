% Reference 11.3: mode/3 and det/2 or semidet/2 are ordinary facts and advisory declarations.
mode(path, 2, [in, out]).
det(path, 2).
semidet(edge, 2).
materialize(answer, 2).
edge(a, b).
path(?x, ?y) :- edge(?x, ?y).
answer(mode_path, ?modes) :- mode(path, 2, ?modes).
answer(det_path, ok) :- det(path, 2).
answer(semidet_edge, ok) :- semidet(edge, 2).
answer(path, ?y) :- path(a, ?y).
