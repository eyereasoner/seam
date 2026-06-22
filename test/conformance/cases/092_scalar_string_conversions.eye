% Reference 9.6: number_string/2, atom_string/2, and term_string/2 are portable scalar bridges.
materialize(answer, 2).
answer(number_to_string, ?x) :- number_string(42, ?x).
answer(decimal_string_to_number, ?x) :- number_string(?x, "-12.75").
answer(scientific_string_to_number, ?x) :- number_string(?x, "1e3").
answer(atom_to_string, ?x) :- atom_string('hello-world', ?x).
answer(string_to_atom_needs_quotes, ?x) :- atom_string(?x, "hello-world").
answer(term_to_string, ?x) :- term_string(result([a, b], score(10)), ?x).
answer(unbound_term_rejected, ok) :- not(term_string(?x, ?s)).
