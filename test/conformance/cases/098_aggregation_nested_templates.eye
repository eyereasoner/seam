% Reference 9.8: aggregation copies resolved structured templates from inner goals.
materialize(answer, 2).
score(alice, math, 9).
score(alice, logic, 7).
score(bob, math, 5).
score(bob, logic, 8).
answer(all_pairs, ?x) :- findall(result(?name, ?subject, ?score), score(?name, ?subject, ?score), ?x).
answer(count_high, ?x) :- countall((score(?name, ?subject, ?score), ge(?score, 8)), ?x).
answer(sum_alice, ?x) :- sumall(?score, score(alice, ?subject, ?score), ?x).
answer(best_score, pair(?key, ?value)) :- aggregate_max(?score, result(?name, ?subject), score(?name, ?subject, ?score), ?key, ?value).
answer(lowest_pair, pair(?key, ?value)) :- aggregate_min([?score, ?name], ?subject, score(?name, ?subject, ?score), ?key, ?value).
