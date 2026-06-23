materialize(answer, 3).
answer(head_and_rest_improper, ?h, ?r) :- head([a | b], ?h), rest([a | b], ?r).
