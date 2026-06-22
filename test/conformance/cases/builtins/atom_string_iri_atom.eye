% atom_string/2 converts an IRI atom to its lexical string.
materialize(answer, 1).
answer(?text) :- atom_string(<urn:example:a>, ?text).
