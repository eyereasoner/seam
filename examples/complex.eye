% Complex numbers, adapted from Eyeling complex.n3.
%
% Complex values are represented as two-item lists [Real, Imaginary], matching
% the pair-shaped pair lists used by the Eyeling source.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
%
% The example derives arithmetic identities, polar conversions, powers, roots,
% exponential/trigonometric functions, and distance/normalization results from
% a small complex-number toolkit.
materialize(complex_power, 4).
materialize(complex_function, 4).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
pi(3.141592653589793).
e(2.718281828459045).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
% z^w is evaluated through polar/log form, exposing useful intermediate proof steps.
complex_exponentiation([?a, ?b], [?c, ?d], [?e, ?f]) :-
  complex_polar([?a, ?b], [?r, ?t]),
  pow(?r, ?c, ?z1),
  neg(?d, ?z2),
  mul(?z2, ?t, ?z3),
  e(?euler),
  pow(?euler, ?z3, ?z4),
  log(?r, ?z5),
  mul(?d, ?z5, ?z6),
  mul(?c, ?t, ?z7),
  add(?z6, ?z7, ?z8),
  cos(?z8, ?z9),
  mul(?z1, ?z4, ?z1z4),
  mul(?z1z4, ?z9, ?e),
  sin(?z8, ?z10),
  mul(?z1z4, ?z10, ?f).

complex_asin([?a, ?b], [?c, ?d]) :-
  add(1, ?a, ?z1),
  pow(?z1, 2, ?z2),
  pow(?b, 2, ?z3),
  add(?z2, ?z3, ?z4),
  pow(?z4, 0.5, ?z5),
  sub(1, ?a, ?z6),
  pow(?z6, 2, ?z7),
  add(?z7, ?z3, ?z8),
  pow(?z8, 0.5, ?z9),
  sub(?z5, ?z9, ?z10),
  div(?z10, 2, ?e),
  add(?z5, ?z9, ?z11),
  div(?z11, 2, ?f),
  asin(?e, ?c),
  pow(?f, 2, ?z12),
  sub(?z12, 1, ?z13),
  pow(?z13, 0.5, ?z14),
  add(?f, ?z14, ?z15),
  log(?z15, ?d).

complex_acos([?a, ?b], [?c, ?d]) :-
  add(1, ?a, ?z1),
  pow(?z1, 2, ?z2),
  pow(?b, 2, ?z3),
  add(?z2, ?z3, ?z4),
  pow(?z4, 0.5, ?z5),
  sub(1, ?a, ?z6),
  pow(?z6, 2, ?z7),
  add(?z7, ?z3, ?z8),
  pow(?z8, 0.5, ?z9),
  sub(?z5, ?z9, ?z10),
  div(?z10, 2, ?e),
  add(?z5, ?z9, ?z11),
  div(?z11, 2, ?f),
  acos(?e, ?c),
  pow(?f, 2, ?z12),
  sub(?z12, 1, ?z13),
  pow(?z13, 0.5, ?z14),
  add(?f, ?z14, ?z15),
  log(?z15, ?u),
  neg(?u, ?d).

complex_polar([?x, ?y], [?r, ?tp]) :-
  pow(?x, 2, ?z1),
  pow(?y, 2, ?z2),
  add(?z1, ?z2, ?z3),
  pow(?z3, 0.5, ?r),
  abs(?x, ?z4),
  div(?z4, ?r, ?z5),
  acos(?z5, ?t),
  complex_dial(?x, ?y, ?t, ?tp).

complex_dial(?x, ?y, ?t, ?tp) :-
  ge(?x, 0),
  ge(?y, 0),
  add(0, ?t, ?tp).

complex_dial(?x, ?y, ?t, ?tp) :-
  lt(?x, 0),
  ge(?y, 0),
  pi(?pi),
  sub(?pi, ?t, ?tp).

complex_dial(?x, ?y, ?t, ?tp) :-
  lt(?x, 0),
  lt(?y, 0),
  pi(?pi),
  add(?pi, ?t, ?tp).

complex_dial(?x, ?y, ?t, ?tp) :-
  ge(?x, 0),
  lt(?y, 0),
  pi(?pi),
  mul(?pi, 2, ?z1),
  sub(?z1, ?t, ?tp).

% Named result rows keep the example output readable.  Each row records the
% operation name, the input value(s), and the computed complex result rather
% than packing all assertions into one large nested term.
complex_power(sqrt_minus_one, [-1, 0], [0.5, 0], ?result) :-
  complex_exponentiation([-1, 0], [0.5, 0], ?result).

complex_power(e_to_i_pi, [2.718281828459045, 0], [0, 3.141592653589793], ?result) :-
  complex_exponentiation([2.718281828459045, 0], [0, 3.141592653589793], ?result).

complex_power(i_to_i, [0, 1], [0, 1], ?result) :-
  complex_exponentiation([0, 1], [0, 1], ?result).

complex_power(e_to_minus_pi_over_two, [2.718281828459045, 0], [-1.57079632679, 0], ?result) :-
  complex_exponentiation([2.718281828459045, 0], [-1.57079632679, 0], ?result).

complex_function(asin, two, [2, 0], ?result) :-
  complex_asin([2, 0], ?result).

complex_function(acos, two, [2, 0], ?result) :-
  complex_acos([2, 0], ?result).
