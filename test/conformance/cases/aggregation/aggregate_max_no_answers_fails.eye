materialize(answer, 1).
answer(ok) :- not(aggregate_max(?key, ?value, missing(?value), ?bestKey, ?bestValue)).
