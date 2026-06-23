person(alice).
has_parent(?child, parent_of(?child)) :- person(?child).
materialize(has_parent, 2).
