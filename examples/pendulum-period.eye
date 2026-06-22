% Science example: simple pendulum period.
%
% For small oscillations, T = 2*pi*sqrt(length / gravity).  Gravity is chosen
% as pi^2 m/s^2 so a one-meter pendulum has a period of two seconds.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(period_s, 2).
materialize(periodError_s, 2).
materialize(status, 2).
materialize(reason, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
constant(pi, 3.141592653589793).
experiment(pendulum1, length_m, 1.0).
experiment(pendulum1, gravity_m_s2, 9.869604401089358).
limit(pendulum1, target_period_s, 2.0).
limit(pendulum1, tolerance_s, 0.01).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
period(?experiment, ?period) :-
  experiment(?experiment, length_m, ?length),
  experiment(?experiment, gravity_m_s2, ?gravity),
  div(?length, ?gravity, ?ratio),
  pow(?ratio, 0.5, ?root),
  constant(pi, ?pi),
  mul(2.0, ?pi, ?twopi),
  mul(?twopi, ?root, ?period).

period_error(?experiment, ?error) :-
  period(?experiment, ?period),
  limit(?experiment, target_period_s, ?target),
  sub(?period, ?target, ?rawerror),
  abs(?rawerror, ?error).

within_period_tolerance(?experiment) :-
  period_error(?experiment, ?error),
  limit(?experiment, tolerance_s, ?tolerance),
  lt(?error, ?tolerance).

period_s(?experiment, ?period) :-
  period(?experiment, ?period).

periodError_s(?experiment, ?error) :-
  period_error(?experiment, ?error).

status(?experiment, within_period_tolerance) :-
  within_period_tolerance(?experiment).

reason(?experiment, "small-angle period matches the two-second target") :-
  within_period_tolerance(?experiment).
