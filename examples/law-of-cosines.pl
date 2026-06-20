% Law of cosines: c^2 = a^2 + b^2 - 2ab cos(C).
%
% The example uses a 60-degree included angle, so cos(C) is represented as 0.5.
% It reports both c^2 and c to make the arithmetic derivation explicit.
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
side_c_squared(Triangle, C2) :-
  triangle(Triangle, A, B, CosC),
  mul(A, A, A2),
  mul(B, B, B2),
  add(A2, B2, Sum),
  mul(2, A, TwoA),
  mul(TwoA, B, TwoAB),
  mul(TwoAB, CosC, Projection),
  sub(Sum, Projection, C2).

side_c(Triangle, C) :-
  side_c_squared(Triangle, C2),
  pow(C2, 0.5, C).

sideCSquared(Triangle, C2) :- side_c_squared(Triangle, C2).
sideC(Triangle, C) :- side_c(Triangle, C).
status(Triangle, acute_triangle) :- side_c_squared(Triangle, C2), gt(C2, 0).
