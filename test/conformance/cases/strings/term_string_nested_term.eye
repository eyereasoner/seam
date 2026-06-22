materialize(answer, 1).
answer(?text) :- term_string(pair(<urn:example:a>, [1, two]), ?text).
