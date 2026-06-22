% Quadratic formula over sample equations.
%
% Each equation is represented as a*x^2 + b*x + c = 0.  The example uses
% eyelang arithmetic predicates to derive the discriminant and the two roots.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(discriminant, 2).
materialize(root, 2).

% equation/4 stores coefficients A, B, and C for each quadratic.  The examples
% use decimal constants so roots and discriminants flow through floating arithmetic.
equation(eq1, 1.0, -5.0, 6.0).
equation(eq2, 2.0, -4.0, -6.0).

% The formula is decomposed into discriminant, square root, -B, denominator,
% and the plus/minus branches so each algebraic step can be inspected.
discriminant(?case, ?d) :-
  equation(?case, ?a, ?b, ?c),
  pow(?b, 2.0, ?b2),
  mul(4.0, ?a, ?foura),
  mul(?foura, ?c, ?fourac),
  sub(?b2, ?fourac, ?d).

sqrt_discriminant(?case, ?s) :-
  discriminant(?case, ?d),
  ge(?d, 0.0),
  pow(?d, 0.5, ?s).

negative_b(?case, ?nb) :-
  equation(?case, ?_a, ?b, ?_c),
  neg(?b, ?nb).

denominator(?case, ?den) :-
  equation(?case, ?a, ?_b, ?_c),
  mul(2.0, ?a, ?den).

root_plus(?case, ?root) :-
  negative_b(?case, ?nb),
  sqrt_discriminant(?case, ?s),
  denominator(?case, ?den),
  add(?nb, ?s, ?numerator),
  div(?numerator, ?den, ?root).

root_minus(?case, ?root) :-
  negative_b(?case, ?nb),
  sqrt_discriminant(?case, ?s),
  denominator(?case, ?den),
  sub(?nb, ?s, ?numerator),
  div(?numerator, ?den, ?root).


root(?case, ?root) :-
  root_plus(?case, ?root).

root(?case, ?root) :-
  root_minus(?case, ?root).
