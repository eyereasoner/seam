% Reference 9.9: holds/3 exposes context members of any arity.
context((ready, name(alice, "Alice"), route(alice, bob, 7))).
answer(parts, exposed(?name, ?args)) :- context(?c), holds(?c, ?name, ?args).
materialize(answer, 2).
