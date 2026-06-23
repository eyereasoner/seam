% Existential-style consequences as explicit Herbrand witness terms.
%
% Eyelang has no blank nodes and no existential variables in rule heads.  The
% practical executable form is to put a named functional term directly in the
% rule head.  The term is ordinary data: stable, visible, and proof-friendly.

materialize(has_parent, 2).
materialize(registration, 3).
materialize(same_witness, 2).
materialize(distinct_witnesses, 2).

person(alice).
person(bob).

takes(alice, logic).
takes(alice, math).
takes(bob, logic).

% One variable: every person has a deterministic parent witness.
has_parent(?child, parent_of(?child)) :-
  person(?child).

% Two variables: every student/course pair has its own registration witness.
registration(?student, ?course, registration_of(?student, ?course)) :-
  takes(?student, ?course).

same_witness(parent_of_alice, true) :-
  eq(parent_of(alice), parent_of(alice)).

distinct_witnesses(alice_logic_vs_alice_math, true) :-
  neq(registration_of(alice, logic), registration_of(alice, math)).
