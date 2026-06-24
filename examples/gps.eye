% GPS route-planning example translated from Eyeling's gps.n3.
% The map is stored as quoted formula data and projected with holds/3.  Route
% paths accumulate action sequence, duration, cost, belief, and comfort; table
% keeps repeated comparison and explanation queries from recomputing paths.

materialize(recommendedRoute, 2).
materialize(outcome, 2).
materialize(statement, 3).
materialize(label, 2).
materialize(actionSequence, 2).
materialize(durationSeconds, 2).
materialize(cost, 2).
materialize(belief, 2).
materialize(comfort, 2).
materialize(selectedRoute, 2).
materialize(comparison, 2).

table(path, 7).
table(traveller_path, 6).

case_graph(caseGraph, (
  location(i1, gent),
  text(question, "Which route should we take from Gent to Oostende?"),
  label(routeDirect, "Gent -> Brugge -> Oostende"),
  label(routeViaKortrijk, "Gent -> Kortrijk -> Brugge -> Oostende")
)).

map_graph(mapBE, (
  gps_description(mapBE, description(location(?s, gent), true, location(?s, brugge), drive_gent_brugge, 1500.0, 0.006, 0.96, 0.99)),
  gps_description(mapBE, description(location(?s, gent), true, location(?s, kortrijk), drive_gent_kortrijk, 1600.0, 0.007, 0.96, 0.99)),
  gps_description(mapBE, description(location(?s, kortrijk), true, location(?s, brugge), drive_kortrijk_brugge, 1600.0, 0.007, 0.96, 0.99)),
  gps_description(mapBE, description(location(?s, brugge), true, location(?s, oostende), drive_brugge_oostende, 900.0, 0.004, 0.98, 1.0))
)).

case_statement(?s, ?p, ?o) :-
  case_graph(caseGraph, ?context),
  holds(?context, ?p, [?s, ?o]).

map_description(?from, ?to, ?action, ?duration, ?cost, ?belief, ?comfort) :-
  map_graph(mapBE, ?context),
  holds(?context, gps_description(mapBE, description(?from, true, ?to, ?action, ?duration, ?cost, ?belief, ?comfort))).

path(?from, ?to, [?action], ?duration, ?cost, ?belief, ?comfort) :-
  map_description(?from, ?to, ?action, ?duration, ?cost, ?belief, ?comfort).

path(?from, ?to, ?actions, ?duration, ?cost, ?belief, ?comfort) :-
  map_description(?from, ?mid, ?action, ?d1, ?c1, ?b1, ?f1),
  path(?mid, ?to, ?restactions, ?d2, ?c2, ?b2, ?f2),
  append([?action], ?restactions, ?actions),
  add(?d1, ?d2, ?duration),
  add(?c1, ?c2, ?cost),
  mul(?b1, ?b2, ?belief),
  mul(?f1, ?f2, ?comfort).

traveller_start(i1, location(i1, gent)).
traveller_goal(i1, location(i1, oostende)).

traveller_path(?traveller, ?actions, ?duration, ?cost, ?belief, ?comfort) :-
  traveller_start(?traveller, ?from),
  traveller_goal(?traveller, ?to),
  path(?from, ?to, ?actions, ?duration, ?cost, ?belief, ?comfort).

route_metrics(routeDirect, ?duration, ?cost, ?belief, ?comfort) :-
  traveller_path(i1, [drive_gent_brugge, drive_brugge_oostende], ?duration, ?cost, ?belief, ?comfort).

route_metrics(routeViaKortrijk, ?duration, ?cost, ?belief, ?comfort) :-
  traveller_path(i1, [drive_gent_kortrijk, drive_kortrijk_brugge, drive_brugge_oostende], ?duration, ?cost, ?belief, ?comfort).

recommended_route(routeDirect) :-
  route_metrics(routeDirect, ?directduration, ?directcost, ?directbelief, ?directcomfort),
  route_metrics(routeViaKortrijk, ?viaduration, ?viacost, ?viabelief, ?viacomfort),
  lt(?directduration, ?viaduration),
  lt(?directcost, ?viacost),
  gt(?directbelief, ?viabelief),
  gt(?directcomfort, ?viacomfort).

outcome(routeDirect, "Take the direct route via Brugge.").

% Verification checks, analogous to the false-producing guards in gps.n3.
check(c1, true) :-
  traveller_path(i1, [drive_gent_brugge, drive_brugge_oostende], ?, ?, ?, ?).

check(c2, true) :-
  traveller_path(i1, [drive_gent_kortrijk, drive_kortrijk_brugge, drive_brugge_oostende], ?, ?, ?, ?).

check(c3, true) :-
  route_metrics(routeDirect, ?d1, ?, ?, ?),
  route_metrics(routeViaKortrijk, ?d2, ?, ?, ?),
  lt(?d1, ?d2).

check(c4, true) :-
  route_metrics(routeDirect, ?, ?c1, ?, ?),
  route_metrics(routeViaKortrijk, ?, ?c2, ?, ?),
  lt(?c1, ?c2).

check(c5, true) :-
  route_metrics(routeDirect, ?, ?, ?b1, ?f1),
  route_metrics(routeViaKortrijk, ?, ?, ?b2, ?f2),
  gt(?b1, ?b2),
  gt(?f1, ?f2).

recommendedRoute(decision, ?route) :-
  recommended_route(?route).

outcome(decision, ?outcome) :-
  recommended_route(?route),
  outcome(?route, ?outcome).

statement(check, ?check, true) :-
  check(?check, true).

route_actions(routeDirect, [drive_gent_brugge, drive_brugge_oostende]).
route_actions(routeViaKortrijk, [drive_gent_kortrijk, drive_kortrijk_brugge, drive_brugge_oostende]).

% Derived route and report relations.  These are consequences of the route search
% and comparison, not pre-written markdown output.
label(?route, ?label) :-
  case_statement(?route, label, ?label),
  route_metrics(?route, ?_duration, ?_cost, ?_belief, ?_comfort).

actionSequence(?route, ?actions) :-
  route_actions(?route, ?actions),
  route_metrics(?route, ?_duration, ?_cost, ?_belief, ?_comfort).

durationSeconds(?route, ?duration) :-
  route_metrics(?route, ?duration, ?_cost, ?_belief, ?_comfort).

cost(?route, ?cost) :-
  route_metrics(?route, ?_duration, ?cost, ?_belief, ?_comfort).

belief(?route, ?belief) :-
  route_metrics(?route, ?_duration, ?_cost, ?belief, ?_comfort).

comfort(?route, ?comfort) :-
  route_metrics(?route, ?_duration, ?_cost, ?_belief, ?comfort).

selectedRoute(report, route(?route, ?actions, ?duration, ?cost, ?belief, ?comfort)) :-
  recommended_route(?route),
  route_actions(?route, ?actions),
  route_metrics(?route, ?duration, ?cost, ?belief, ?comfort).

comparison(report, dominates(routeDirect, routeViaKortrijk)) :-
  recommended_route(routeDirect),
  check(c3, true),
  check(c4, true),
  check(c5, true).
