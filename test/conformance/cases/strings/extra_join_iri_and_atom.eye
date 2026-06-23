materialize(answer, 2).
answer(join_iri_and_atom, ?x) :- join([<urn:example:a>, path, 7], "/", ?x).
