materialize(answer, 2).
answer(reverse_nested_terms, ?x) :- reverse([box(a), [b, c], <urn:example:d>], ?x).
