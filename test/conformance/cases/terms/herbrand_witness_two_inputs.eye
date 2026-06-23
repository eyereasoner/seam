% Existential-style consequence with two universal variables represented as a Herbrand term.
materialize(answer, 3).
takes(alice, logic).
takes(alice, math).
answer(?student, ?course, registration_of(?student, ?course)) :- takes(?student, ?course).
