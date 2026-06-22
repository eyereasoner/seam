materialize(answer, 2).
candidate(a, 3).
candidate(b, 1).
candidate(c, 2).
answer(?key, ?value) :- aggregate_min(score(?score), ?name, candidate(?name, ?score), ?key, ?value).
