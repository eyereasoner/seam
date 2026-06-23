score(a, 4).
score(b, 5).
score(c, -2).
answer(sum, ?sum) :- sumall(?s, score(?_item, ?s), ?sum).
materialize(answer, 2).
