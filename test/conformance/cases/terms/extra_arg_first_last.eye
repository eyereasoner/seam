materialize(answer, 3).
answer(arg_first_last, ?first, ?last) :- arg(1, triple(a, b, c), ?first), arg(3, triple(a, b, c), ?last).
