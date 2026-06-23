materialize(answer, 3).
score(2, b).
score(1, a).
answer(aggregate_min, ?key, ?value) :- aggregate_min(?k, ?v, score(?k, ?v), ?key, ?value).
