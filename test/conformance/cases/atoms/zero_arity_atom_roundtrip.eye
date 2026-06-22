% Arity-zero data is represented as atoms, never zero-arity compounds.
materialize(answer, 2).
answer(name, ?name) :- compound_name_arguments(nil, ?name, ?args).
answer(args, ?args) :- compound_name_arguments(nil, ?name, ?args).
answer(term, ?term) :- compound_name_arguments(?term, nil, []).
