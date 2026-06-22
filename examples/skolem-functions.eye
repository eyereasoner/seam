% Skolem functional terms in rule heads.
%
% A generated resource should be deterministic and collision-free. Use a
% function symbol whose arguments contain the values that make the resource
% unique, such as skolem_observation(Patient, Test).

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(type, 2).
materialize(patient, 2).
materialize(test, 2).
materialize(value, 2).
materialize(about, 2).
materialize(sameInputsSameId, 2).
materialize(noObservationClash, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
test_result(alice, glucose, 6.8).
test_result(alice, cholesterol, 4.2).
test_result(bob, glucose, 5.1).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
high_glucose(?patient) :-
  test_result(?patient, glucose, ?value),
  gt(?value, 6.0).

observation_id(?patient, ?test, skolem_observation(?patient, ?test)) :-
  test_result(?patient, ?test, ?_value).

type(skolem_observation(?patient, ?test), observation) :-
  test_result(?patient, ?test, ?_value).

patient(skolem_observation(?patient, ?test), ?patient) :-
  test_result(?patient, ?test, ?_value).

test(skolem_observation(?patient, ?test), ?test) :-
  test_result(?patient, ?test, ?_value).

value(skolem_observation(?patient, ?test), ?value) :-
  test_result(?patient, ?test, ?value).

type(skolem_alert(?patient, glucose), highGlucoseAlert) :-
  high_glucose(?patient).

about(skolem_alert(?patient, glucose), skolem_observation(?patient, glucose)) :-
  high_glucose(?patient).

sameInputsSameId(skolemDemo, true) :-
  eq(skolem_observation(alice, glucose), skolem_observation(alice, glucose)).

noObservationClash(skolemDemo, true) :-
  neq(skolem_observation(alice, glucose), skolem_observation(alice, cholesterol)),
  neq(skolem_observation(alice, glucose), skolem_observation(bob, glucose)).
