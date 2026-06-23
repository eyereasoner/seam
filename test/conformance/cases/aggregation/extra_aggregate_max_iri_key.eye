materialize(answer, 3).
rank(<urn:example:a>, low).
rank(<urn:example:z>, high).
answer(aggregate_max_iri_key, ?key, ?value) :- aggregate_max(?k, ?v, rank(?k, ?v), ?key, ?value).
