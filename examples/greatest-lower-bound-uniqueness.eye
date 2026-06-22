% Order-theory proof sketch: greatest lower bounds are unique.
%
% Two candidate GLBs are asserted for the same pair.  The rules derive that
% each must be below the other, then use antisymmetry-style sameTerm/2 reasoning
% to report that the candidates denote the same lower bound.
materialize(sameGreatestLowerBound, 4).

% Adapted from Eyeling greatest-lower-bound-uniqueness.n3.  The named facts
% intentionally use two different symbols, g1 and g2, so the final output shows
% the equality-style conclusion as an explicit derived relation.

glbOf(g1, a, b).
glbOf(g2, a, b).

% leq/2 captures the defining property of a GLB: every lower bound is below it.
lowerBoundOf(?m, ?a, ?b) :- glbOf(?m, ?a, ?b).

leq(?l, ?m) :-
  glbOf(?m, ?a, ?b),
  lowerBoundOf(?l, ?a, ?b).

sameTerm(?m, ?n) :-
  leq(?m, ?n),
  leq(?n, ?m).

sameGreatestLowerBound(?a, ?b, ?m, ?n) :-
  glbOf(?m, ?a, ?b),
  glbOf(?n, ?a, ?b),
  sameTerm(?m, ?n),
  neq(?m, ?n).
