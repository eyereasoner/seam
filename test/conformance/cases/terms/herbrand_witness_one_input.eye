% Existential-style consequence with one universal variable represented as a Herbrand term.
materialize(answer, 2).
person(alice).
person(bob).
answer(?child, parent_of(?child)) :- person(?child).
