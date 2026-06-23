materialize(answer, 3).
answer(holds_list_parts, ?name, ?args) :- holds(([a, b], tail), ?name, ?args).
