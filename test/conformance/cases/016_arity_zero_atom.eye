% Reference 4, 5.3: arity-zero data is written as an atom constant.
status(nil, ok).
answer(value, ?x) :- status(?x, ok).
materialize(answer, 2).
