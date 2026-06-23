materialize(answer, 2).
answer(nested_list_binding, ?tail) :- eq([a, b | ?tail], [a, b, c]).
