materialize(answer, 1).
answer(?tail) :- eq([a, b, c], [a | ?tail]).
