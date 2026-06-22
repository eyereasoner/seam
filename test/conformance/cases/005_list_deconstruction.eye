% Reference 5.4, 12.1: list syntax and unification in rule heads.
first([?x | ?_rest], ?x).
tail([?_head | ?tail], ?tail).
answer(first, ?x) :- first([a, b, c], ?x).
answer(tail, ?tail) :- tail([a, b, c], ?tail).
materialize(answer, 2).
