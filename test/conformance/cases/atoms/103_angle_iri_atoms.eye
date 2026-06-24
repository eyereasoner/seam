% Reference 3.5: absolute IRIs may be written as angle-bracket atom constants.
materialize(iri_subject, 1).
materialize(iri_object, 1).
triple(<https://example.org/alice>, <https://schema.org/name>, "Alice").
triple(<urn:example:bob>, <https://schema.org/knows>, <https://example.org/alice>).
iri_subject(?iri) :- triple(?iri, ?, ?).
iri_object(?iri) :- triple(?, <https://schema.org/knows>, ?iri).
