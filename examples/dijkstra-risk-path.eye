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
table(route_cost, 4).

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
route_segment(?from, ?to, ?raw, ?risk) :-
  route_network(riskNetwork, ?context),
  holds(?context, segment(?from, segment(?to, ?raw, ?risk))).

candidate(pathB, [depotA, depotB, labD]).
candidate(pathC, [depotA, depotC, labD]).
candidate(pathRelay, [depotA, relay, labD]).
candidate(pathDirectC, [depotA, labD]).
candidate(pathViaC, [depotA, depotC, depotB, labD]).

route_cost([?_], 0.0, 0.0, 0).
route_cost([?from, ?to|?rest], ?raw, ?risk, ?edges) :-
  route_segment(?from, ?to, ?stepraw, ?steprisk),
  route_cost([?to|?rest], ?restraw, ?restrisk, ?restedges),
  add(?stepraw, ?restraw, ?raw),
  add(?steprisk, ?restrisk, ?risk),
  add(1, ?restedges, ?edges).

score(?raw, ?risk, ?score) :-
  mul(?risk, 10.0, ?penalty),
  add(?raw, ?penalty, ?score).

path_metrics(?path, ?route, ?raw, ?risk, ?score, ?edges) :-
  candidate(?path, ?route),
  route_cost(?route, ?raw, ?risk, ?edges),
  score(?raw, ?risk, ?score).

% Pick the known winner by comparing its score with every other candidate.
best_path(pathB) :-
  path_metrics(pathB, ?_bestroute, ?_bestraw, ?_bestrisk, ?bestscore, ?_bestedges),
  path_metrics(pathC, ?_croute, ?_craw, ?_crisk, ?cscore, ?_cedges),
  path_metrics(pathRelay, ?_rroute, ?_rraw, ?_rrisk, ?relayscore, ?_redges),
  path_metrics(pathDirectC, ?_droute, ?_draw, ?_drisk, ?directscore, ?_dedges),
  path_metrics(pathViaC, ?_vroute, ?_vraw, ?_vrisk, ?viascore, ?_vedges),
  lt(?bestscore, ?cscore),
  lt(?bestscore, ?relayscore),
  lt(?bestscore, ?directscore),
  lt(?bestscore, ?viascore).

risk_outweighs_raw_cost(true) :-
  path_metrics(pathB, ?_br, ?bestraw, ?_brs, ?bestscore, ?_be),
  path_metrics(pathViaC, ?_vr, ?viaraw, ?_vrs, ?viascore, ?_ve),
  lt(?viaraw, ?bestraw),
  lt(?bestscore, ?viascore).

route(?path, ?route) :- path_metrics(?path, ?route, ?_raw, ?_risk, ?_score, ?_edges).
rawCost(?path, ?raw) :- path_metrics(?path, ?_route, ?raw, ?_risk, ?_score, ?_edges).
riskSum(?path, ?risk) :- path_metrics(?path, ?_route, ?_raw, ?risk, ?_score, ?_edges).
score(?path, ?score) :- path_metrics(?path, ?_route, ?_raw, ?_risk, ?score, ?_edges).
edgeCount(?path, ?edges) :- path_metrics(?path, ?_route, ?_raw, ?_risk, ?_score, ?edges).
selectedPath(case, ?path) :- best_path(?path).
trustGate(case, noEnumeratedPathIsLower) :- best_path(?_path).
notes(case, riskCanOutweighRawCost) :- risk_outweighs_raw_cost(true).
selects(dijkstraRiskPath, ?path) :- best_path(?path), risk_outweighs_raw_cost(true).
