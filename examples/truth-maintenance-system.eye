% A tiny assumption-based truth maintenance system.
%
% An environment is a set of assumptions.  Justifications derive beliefs from
% assumptions and from other derived beliefs.  The TMS can therefore explain
% which environments support a belief and which environments are inconsistent
% because they support contradictory conclusions.

materialize(tmsSupport, 2).
materialize(tmsJustification, 3).
materialize(tmsInconsistent, 1).
materialize(tmsConclusion, 2).

table(supported, 2).

% Candidate environments.
environment(clear_only, [sensor_clear]).
environment(blocked_only, [sensor_blocked]).
environment(conflicting_sensors, [sensor_clear, sensor_blocked]).
environment(override_blocked, [sensor_blocked, operator_override]).

assumes(?environment, ?assumption) :-
  environment(?environment, ?assumptions),
  member(?assumption, ?assumptions).

% Justifications.  Preconditions are either assumption(Name) or another derived
% belief.  The last justification says an operator override can permit motion
% even when the blocked-path belief is also present.
justification(j_clear_path, [assumption(sensor_clear)], clear_path).
justification(j_blocked_path, [assumption(sensor_blocked)], blocked_path).
justification(j_permit_from_clear, [clear_path], permit_go).
justification(j_forbid_from_blocked, [blocked_path], forbid_go).
justification(j_override, [assumption(operator_override), blocked_path], permit_go).

all_hold(?, []).
all_hold(?environment, [assumption(?assumption) | ?rest]) :-
  assumes(?environment, ?assumption),
  all_hold(?environment, ?rest).
all_hold(?environment, [?belief | ?rest]) :-
  supported(?environment, ?belief),
  all_hold(?environment, ?rest).

supported(?environment, ?belief) :-
  justification(?, ?preconditions, ?belief),
  all_hold(?environment, ?preconditions).

contradicts(permit_go, forbid_go).
contradicts(forbid_go, permit_go).
inconsistent(?environment) :-
  supported(?environment, ?left),
  supported(?environment, ?right),
  contradicts(?left, ?right).

% Show the actual justifications that fired, not just the final supported beliefs.
fires(?environment, ?justification, ?belief) :-
  justification(?justification, ?preconditions, ?belief),
  all_hold(?environment, ?preconditions).

tmsSupport(?environment, ?belief) :- supported(?environment, ?belief).
tmsJustification(?environment, ?justification, ?belief) :- fires(?environment, ?justification, ?belief).
tmsInconsistent(?environment) :- inconsistent(?environment).
tmsConclusion(case, "truth maintenance separates support from consistency across assumption environments") :-
  inconsistent(conflicting_sensors).
