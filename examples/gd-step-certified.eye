% Memoize interval computations reused across width, midpoint, gradient, step,
% objective, and contraction report relations.
% Output declarations: materialize/2 selects the relations written to this example's golden output.
%
% This is a proof-friendly optimization trace: every numeric fact needed to
% justify the step is materialized, so proof output can certify why the update
% is accepted.
materialize(eta, 2).
materialize(etaLeHalf, 2).
materialize(xBounds, 2).
materialize(midpoint, 2).
materialize(width, 2).
materialize(gradientBounds, 2).
materialize(stepBounds, 2).
materialize(objectiveBounds, 2).
materialize(widthContractsAt, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
table(x_bounds, 3).
table(width, 2).
table(g_bounds, 3).
table(p_bounds, 3).
table(midpoint, 3).
table(f_lower, 2).
table(f_upper, 2).

% Adapted from Eyeling's gd-step-certified.n3.
% One-dimensional gradient descent over certified interval bounds.

max_k(10).
target(1.0).
% Derivation rules: each rule below contributes one logical step toward the displayed results.
eta(?eta) :- div(1.0, 5, ?eta).
x_bounds(0, 0.0, 2.0).

index(0). index(1). index(2). index(3). index(4). index(5).
index(6). index(7). index(8). index(9). index(10).

previous(1, 0). previous(2, 1). previous(3, 2). previous(4, 3). previous(5, 4).
previous(6, 5). previous(7, 6). previous(8, 7). previous(9, 8). previous(10, 9).

g_bounds(?k, ?gl, ?gu) :-
  target(?a),
  x_bounds(?k, ?l, ?u),
  sub(?l, ?a, ?dl),
  sub(?u, ?a, ?du),
  mul(2, ?dl, ?gl),
  mul(2, ?du, ?gu).

p_bounds(?k, ?pl, ?pu) :-
  eta(?eta),
  g_bounds(?k, ?gl, ?gu),
  mul(?eta, ?gl, ?pl),
  mul(?eta, ?gu, ?pu).

x_bounds(?k1, ?l1, ?u1) :-
  previous(?k1, ?k),
  x_bounds(?k, ?l, ?u),
  target(?a),
  eta(?eta),
  sub(?l, ?a, ?dl),
  sub(?u, ?a, ?du),
  mul(2, ?dl, ?gl),
  mul(2, ?du, ?gu),
  mul(?eta, ?gl, ?pl),
  mul(?eta, ?gu, ?pu),
  sub(?l, ?pu, ?l1),
  sub(?u, ?pl, ?u1).

width(?k, ?w) :-
  x_bounds(?k, ?l, ?u),
  sub(?u, ?l, ?w).

midpoint(?k, ?m, ?halfw) :-
  x_bounds(?k, ?l, ?u),
  width(?k, ?w),
  div(?w, 2, ?halfw),
  add(?l, ?u, ?sum),
  div(?sum, 2, ?m).

eta_le_half(true) :-
  eta(?eta),
  div(1.0, 2, ?half),
  le(?eta, ?half).

width_contracts_at(?k1, true) :-
  eta_le_half(true),
  previous(?k1, ?k),
  width(?k, ?w),
  width(?k1, ?w1),
  le(?w1, ?w).

max2(?a, ?b, ?a) :- ge(?a, ?b).
max2(?a, ?b, ?b) :- lt(?a, ?b).
min2(?a, ?b, ?a) :- le(?a, ?b).
min2(?a, ?b, ?b) :- gt(?a, ?b).

end_squares(?k, ?sl, ?su) :-
  target(?a),
  x_bounds(?k, ?l, ?u),
  sub(?l, ?a, ?dl),
  sub(?u, ?a, ?du),
  mul(?dl, ?dl, ?sl),
  mul(?du, ?du, ?su).

f_upper(?k, ?fu) :-
  end_squares(?k, ?sl, ?su),
  max2(?sl, ?su, ?fu).

f_lower(?k, 0.0) :-
  target(?a),
  x_bounds(?k, ?l, ?u),
  le(?l, ?a),
  le(?a, ?u).

f_lower(?k, ?fl) :-
  target(?a),
  x_bounds(?k, ?l, ?u),
  lt(?u, ?a),
  end_squares(?k, ?sl, ?su),
  min2(?sl, ?su, ?fl).

f_lower(?k, ?fl) :-
  target(?a),
  x_bounds(?k, ?l, ?u),
  lt(?a, ?l),
  end_squares(?k, ?sl, ?su),
  min2(?sl, ?su, ?fl).

eta(result, ?eta) :-
  eta(?eta).

etaLeHalf(result, true) :-
  eta_le_half(true).

xBounds(result, bounds(?k, ?l, ?u)) :-
  index(?k),
  x_bounds(?k, ?l, ?u).

midpoint(result, midpoint(?k, ?m, ?halfw)) :-
  index(?k),
  midpoint(?k, ?m, ?halfw).

width(result, width(?k, ?w)) :-
  index(?k),
  width(?k, ?w).

gradientBounds(result, gradient(?k, ?gl, ?gu)) :-
  index(?k),
  g_bounds(?k, ?gl, ?gu).

stepBounds(result, step(?k, ?pl, ?pu)) :-
  index(?k),
  p_bounds(?k, ?pl, ?pu).

objectiveBounds(result, f(?k, ?fl, ?fu)) :-
  index(?k),
  f_lower(?k, ?fl),
  f_upper(?k, ?fu).

widthContractsAt(result, ?k) :-
  width_contracts_at(?k, true).
