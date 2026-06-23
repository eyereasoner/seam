materialize(answer, 2).
answer(last_singleton, ?x) :- last([only], ?x).
