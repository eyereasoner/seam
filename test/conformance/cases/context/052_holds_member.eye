% Reference 9.9: holds/2 over comma context data.
context((name(alice, "Alice"), knows(alice, bob))).
answer(member, ?term) :- context(?c), holds(?c, ?term).
