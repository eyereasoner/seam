materialize(answer, 2).
answer(head, ?x) :- head([a, b, c], ?x).
answer(rest, ?x) :- rest([a, b, c], ?x).
answer(last, ?x) :- last([a, b, c], ?x).
