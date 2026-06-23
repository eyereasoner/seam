% Reference 9.9: holds/2 and holds/3 enumerate comma-context terms left to right.
materialize(answer, 2).
context((kind(alert), severity(high), owner(alice))).
answer(term, ?x) :- context(?c), holds(?c, ?x).
answer(parts, pair(?name, ?args)) :- context(?c), holds(?c, ?name, ?args).
answer(filter, ?x) :- context(?c), holds(?c, owner(?x)).
answer(missing_rejected, ok) :- context(?c), not(holds(?c, status(open))).
