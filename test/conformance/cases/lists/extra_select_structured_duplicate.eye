materialize(answer, 2).
answer(select_structured_duplicate, ?rest) :- select(box(a), [box(a), box(b), box(a)], ?rest).
