item(a).
item(b).
answer(counts, counts(?c, ?z)) :- countall(item(?x), ?c), countall(missing(?x), ?z).
materialize(answer, 2).
