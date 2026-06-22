score(alpha, 7).
score(beta, 7).
score(gamma, 5).
answer(max, result(?key, ?bestname)) :- aggregate_max([?s, ?name], ?name, score(?name, ?s), ?key, ?bestname).
materialize(answer, 2).
