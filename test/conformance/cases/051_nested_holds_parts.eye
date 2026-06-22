% Reference 9.9: holds/3 enumerates nested comma contexts.
context(((ready, name(a, "A")), route(a, b, 7))).
answer(parts, exposed(?name, ?args)) :- context(?c), holds(?c, ?name, ?args).
materialize(answer, 2).
