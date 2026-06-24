% Route planning with explicit route terms.
%
% This is the Eyelang version of the classic Paris-to-Nantes path example: the
% facts describe one-way road links, and `path/2` derives both the endpoint pair
% and a structured `go(..., ..., ...)` plan.  The plan is ordinary data, so the
% route can be inspected, stored, or used by later rules.

materialize(route_to_nantes, 2).
table(path, 2).
mode(path, 2, [in, out]).

oneway(paris, orleans).
oneway(paris, chartres).
oneway(paris, amiens).
oneway(orleans, blois).
oneway(orleans, bourges).
oneway(blois, tours).
oneway(chartres, lemans).
oneway(lemans, angers).
oneway(lemans, tours).
oneway(angers, nantes).

% A direct edge is a one-step plan.
path([?a, ?b], go(?a, ?b, goal)) :-
  oneway(?a, ?b).

% A longer path prepends one edge to the remaining plan.
path([?a, ?c], go(?a, ?b, ?rest)) :-
  oneway(?a, ?b),
  path([?b, ?c], ?rest).

route_to_nantes(?from, ?plan) :-
  path([?from, nantes], ?plan).
