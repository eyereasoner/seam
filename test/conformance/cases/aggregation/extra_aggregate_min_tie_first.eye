materialize(answer, 3).
score(2, first).
score(1, keep).
score(1, also).
answer(aggregate_min_tie_first, ?key, ?value) :- aggregate_min(?k, ?v, score(?k, ?v), ?key, ?value).
