% Equivalence-class overlap example adapted from Eyeling.
%
% The finite classMember/2 facts represent an already-computed equivalence
% closure.  sameClassBecauseOfSharedMember/3 reports the witness Z proving that
% X and Y belong to the same class because both contain that shared member.
%
% This is useful for proof output: the conclusion is not just that two class
% labels coincide, but also which element explains the overlap.
materialize(sameClassBecauseOfSharedMember, 3).

classMember(class_abc, a).
classMember(class_abc, b).
classMember(class_abc, c).

inClassOf(?u, ?x) :-
  classMember(?class, ?u),
  classMember(?class, ?x).

sameClass(?x, ?y) :-
  classMember(?class, ?x),
  classMember(?class, ?y).

sameClassBecauseOfSharedMember(?x, ?y, ?z) :-
  inClassOf(?z, ?x),
  inClassOf(?z, ?y),
  sameClass(?x, ?y),
  neq(?x, ?y).
