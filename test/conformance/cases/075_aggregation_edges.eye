% Reference 9.1: aggregation handles empty result sets, structured templates, and ordered best answers.
materialize(answer, 2).
score(alice, 2).
score(bob, 1).
score(cara, 3).
answer(findall_empty, ?x) :- findall(?v, missing(?v), ?x).
answer(count_filtered, ?x) :- countall((score(?name, ?score), gt(?score, 1)), ?x).
answer(sum_empty, ?x) :- sumall(?v, missing(?v), ?x).
answer(sum_scores, ?x) :- sumall(?score, score(?name, ?score), ?x).
answer(best_min, pair(?key, ?value)) :- aggregate_min(?score, ?name, score(?name, ?score), ?key, ?value).
answer(best_max, pair(?key, ?value)) :- aggregate_max(?score, ?name, score(?name, ?score), ?key, ?value).
answer(best_empty_rejected, ok) :- not(aggregate_min(?key, ?value, missing(?value), ?key, ?value)).
