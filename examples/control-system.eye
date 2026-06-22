% Control Systems example, adapted from Eyelet's input/control-system.eye.
%
% The example combines measurements, observations, targets, logarithmic
% feedforward compensation, square-root normalization, and nonlinear feedback.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
%
% Each derived quantity is represented as its own predicate rather than a single
% formula blob, making the proof trace useful for debugging a failed actuator
% normalization or control-signal calculation.
materialize(controlSignal, 2).
materialize(status, 2).
materialize(normalizedMeasurement, 2).
materialize(log10, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
measurement(input1, [6, 11]).
measurement(disturbance2, [45, 39]).
measurement(input2, true).
measurement(input3, 56967).
measurement(disturbance1, 35766).
measurement(output2, 24).

observation(state1, 80).
observation(state2, false).
observation(state3, 22).

target(output2, 29).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
measurement_normalized(?i, ?m) :-
  measurement(?i, [?m1, ?m2]),
  lt(?m1, ?m2),
  sub(?m2, ?m1, ?delta),
  pow(?delta, 0.5, ?m).

measurement_normalized(?i, ?m1) :-
  measurement(?i, [?m1, ?m2]),
  ge(?m1, ?m2).

log10(?value, ?result) :-
  log(?value, ?naturallog),
  log(10, ?naturallog10),
  div(?naturallog, ?naturallog10, ?result).

control(actuator1, ?c) :-
  measurement_normalized(input1, ?m1),
  measurement(input2, true),
  measurement(disturbance1, ?d1),
  mul(?m1, 19.6, ?proportional),
  log10(?d1, ?compensation),
  sub(?proportional, ?compensation, ?c).

control(actuator2, ?c) :-
  observation(state3, ?p3),
  measurement(output2, ?m4),
  target(output2, ?t2),
  sub(?t2, ?m4, ?error),
  sub(?p3, ?m4, ?differentialerror),
  mul(5.8, ?error, ?proportional),
  div(7.3, ?error, ?nonlinearfactor),
  mul(?nonlinearfactor, ?differentialerror, ?differential),
  add(?proportional, ?differential, ?c).

controlSignal(?actuator, ?c) :-
  control(?actuator, ?c).

status(?actuator, active) :-
  control(?actuator, ?_c).

normalizedMeasurement(input1, ?m) :-
  measurement_normalized(input1, ?m).

log10(disturbance1, ?c) :-
  measurement(disturbance1, ?d),
  log10(?d, ?c).
