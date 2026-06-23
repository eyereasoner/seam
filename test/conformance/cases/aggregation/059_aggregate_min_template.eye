score(alpha, 7).
score(beta, 3).
score(gamma, 5).
answer(min, result(?bests, ?best)) :- aggregate_min(?s, item(?name, ?s), score(?name, ?s), ?bests, ?best).
materialize(answer, 2).
