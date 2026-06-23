materialize(answer, 2).
table(edge, 2).
edge(a, b).
edge(b, c).
answer(table_open_call_fallback, pair(?x, ?y)) :- edge(?x, ?y).
