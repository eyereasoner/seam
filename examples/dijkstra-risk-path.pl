% Risk-adjusted route selection adapted from Eyeling dijkstra-risk-path.n3.
%
% The score is raw delivery cost plus ten times accumulated risk.  Candidate
% routes are fixed path lists, while route_cost/4 reduces each list to raw cost,
% risk, and edge count.  Memoization lets selected-path, scoring, and trust-gate
% relations reuse those reductions.
materialize(route, 2).
materialize(rawCost, 2).
materialize(riskSum, 2).
materialize(score, 2).
materialize(edgeCount, 2).
materialize(selectedPath, 2).
materialize(trustGate, 2).
materialize(notes, 2).
materialize(selects, 2).

% Cache route-list reductions because several materialized reports ask for the same metrics.
memoize(route_cost, 4).

% Segments live in a quoted formula term, while candidate paths remain ordinary lists.
route_network(riskNetwork, (
  segment(depotA, segment(depotB, 4.0, 0.2)),
  segment(depotB, segment(labD, 4.0, 0.3)),
  segment(depotA, segment(depotC, 3.0, 0.9)),
  segment(depotC, segment(labD, 6.0, 0.3)),
  segment(depotC, segment(depotB, 0.5, 0.5)),
  segment(depotB, segment(depotC, 1.0, 0.5)),
  segment(depotA, segment(relay, 5.0, 0.2)),
  segment(relay, segment(labD, 5.0, 0.2)),
  segment(depotA, segment(labD, 14.0, 0.05))
)).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
route_segment(From, To, Raw, Risk) :-
  route_network(riskNetwork, Context),
  holds(Context, segment(From, segment(To, Raw, Risk))).

candidate(pathB, [depotA, depotB, labD]).
candidate(pathC, [depotA, depotC, labD]).
candidate(pathRelay, [depotA, relay, labD]).
candidate(pathDirectC, [depotA, labD]).
candidate(pathViaC, [depotA, depotC, depotB, labD]).

route_cost([_], 0.0, 0.0, 0).
route_cost([From, To|Rest], Raw, Risk, Edges) :-
  route_segment(From, To, StepRaw, StepRisk),
  route_cost([To|Rest], RestRaw, RestRisk, RestEdges),
  add(StepRaw, RestRaw, Raw),
  add(StepRisk, RestRisk, Risk),
  add(1, RestEdges, Edges).

score(Raw, Risk, Score) :-
  mul(Risk, 10.0, Penalty),
  add(Raw, Penalty, Score).

path_metrics(Path, Route, Raw, Risk, Score, Edges) :-
  candidate(Path, Route),
  route_cost(Route, Raw, Risk, Edges),
  score(Raw, Risk, Score).

% Pick the known winner by comparing its score with every other candidate.
best_path(pathB) :-
  path_metrics(pathB, _BestRoute, _BestRaw, _BestRisk, BestScore, _BestEdges),
  path_metrics(pathC, _CRoute, _CRaw, _CRisk, CScore, _CEdges),
  path_metrics(pathRelay, _RRoute, _RRaw, _RRisk, RelayScore, _REdges),
  path_metrics(pathDirectC, _DRoute, _DRaw, _DRisk, DirectScore, _DEdges),
  path_metrics(pathViaC, _VRoute, _VRaw, _VRisk, ViaScore, _VEdges),
  lt(BestScore, CScore),
  lt(BestScore, RelayScore),
  lt(BestScore, DirectScore),
  lt(BestScore, ViaScore).

risk_outweighs_raw_cost(true) :-
  path_metrics(pathB, _BR, BestRaw, _BRS, BestScore, _BE),
  path_metrics(pathViaC, _VR, ViaRaw, _VRS, ViaScore, _VE),
  lt(ViaRaw, BestRaw),
  lt(BestScore, ViaScore).

route(Path, Route) :- path_metrics(Path, Route, _Raw, _Risk, _Score, _Edges).
rawCost(Path, Raw) :- path_metrics(Path, _Route, Raw, _Risk, _Score, _Edges).
riskSum(Path, Risk) :- path_metrics(Path, _Route, _Raw, Risk, _Score, _Edges).
score(Path, Score) :- path_metrics(Path, _Route, _Raw, _Risk, Score, _Edges).
edgeCount(Path, Edges) :- path_metrics(Path, _Route, _Raw, _Risk, _Score, Edges).
selectedPath(case, Path) :- best_path(Path).
trustGate(case, noEnumeratedPathIsLower) :- best_path(_Path).
notes(case, riskCanOutweighRawCost) :- risk_outweighs_raw_cost(true).
selects(dijkstraRiskPath, Path) :- best_path(Path), risk_outweighs_raw_cost(true).
