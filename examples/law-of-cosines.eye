% Law of cosines: c^2 = a^2 + b^2 - 2ab cos(C).
%
% This pure-geometry example keeps trigonometry outside the language by storing
% cos(C) as data.  Eyelang then performs the algebraic part of the theorem with
% ordinary arithmetic predicates and materializes both c^2 and c.
%
% The 60-degree sample uses cos(C) = 0.5, so the proof shows each intermediate
% numeric step rather than hiding the computation in one builtin.
materialize(sideCSquared, 2).
materialize(sideC, 2).
materialize(status, 2).

% The triangle fact stores the two known sides and the cosine of the included
% angle.  Storing cos(C) directly avoids needing trigonometric built-ins while
% still demonstrating the geometric formula.
triangle(tri60, 7, 9, 0.5).

% Compute c^2 first so both squared and square-rooted outputs can be shown.
% side_c_squared/2 follows the law of cosines step by step, then side_c/2
% takes the square root for the reported side length.
side_c_squared(?triangle, ?c2) :-
  triangle(?triangle, ?a, ?b, ?cosc),
  mul(?a, ?a, ?a2),
  mul(?b, ?b, ?b2),
  add(?a2, ?b2, ?sum),
  mul(2, ?a, ?twoa),
  mul(?twoa, ?b, ?twoab),
  mul(?twoab, ?cosc, ?projection),
  sub(?sum, ?projection, ?c2).

side_c(?triangle, ?c) :-
  side_c_squared(?triangle, ?c2),
  pow(?c2, 0.5, ?c).

sideCSquared(?triangle, ?c2) :- side_c_squared(?triangle, ?c2).
sideC(?triangle, ?c) :- side_c(?triangle, ?c).
status(?triangle, acute_triangle) :- side_c_squared(?triangle, ?c2), gt(?c2, 0).
