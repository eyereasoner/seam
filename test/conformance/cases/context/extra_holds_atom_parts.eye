materialize(answer, 3).
answer(holds_atom_parts, ?name, ?args) :- holds((ready, box(a)), ?name, ?args).
