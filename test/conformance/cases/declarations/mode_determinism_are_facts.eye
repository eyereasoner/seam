% Advisory declarations are also ordinary facts that programs can inspect.
mode(path, 2, [in, out]).
semidet(edge, 2).
det(root, 1).
materialize(answer, 2).
answer(mode, ?modes) :- mode(path, 2, ?modes).
answer(semidet, edge) :- semidet(edge, 2).
answer(det, root) :- det(root, 1).
