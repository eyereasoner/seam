materialize(answer, 3).
answer(?name, ?left, ?right) :- holds((edge(a, b), label(a, "A")), ?name, [?left, ?right]).
