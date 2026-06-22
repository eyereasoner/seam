% Weighted path enumeration adapted from Eyeling dijkstra.n3.
%
% The Eyeling source uses collect/sort built-ins for Dijkstra's queue.  This
% eyelang variant enumerates simple paths, keeps the bounded frontier shown in
% the Eyeling output for a -> f, and scopes the graph inside a quoted term so the
% route network is not asserted as ambient edge facts.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(edge, 2).
materialize(path, 2).

% The weighted graph stays inside weighted_graph/2; base_link/3 projects only
% the scoped edges needed by this example before the undirected link/3 view is built.
weighted_graph(dijkstraGraph, (
  edge(a, arc(b, 4)),
  edge(a, arc(c, 2)),
  edge(b, arc(c, 1)),
  edge(b, arc(d, 5)),
  edge(c, arc(d, 8)),
  edge(c, arc(e, 10)),
  edge(d, arc(e, 2)),
  edge(d, arc(f, 6)),
  edge(e, arc(f, 3))
)).

% path/5 carries both the visited list and accumulated cost, so the search
% enumerates simple weighted routes without asserting intermediate route facts.
base_link(?a, ?b, ?cost) :-
  weighted_graph(dijkstraGraph, ?context),
  holds(?context, edge(?a, arc(?b, ?cost))).

% Build an undirected view from directed base edges.
link(?a, ?b, ?cost) :- base_link(?a, ?b, ?cost).
link(?b, ?a, ?cost) :- base_link(?a, ?b, ?cost).

path(?goal, ?goal, ?_visited, [?goal], 0).
path(?node, ?goal, ?visited, [?node|?path], ?cost) :-
  link(?node, ?next, ?stepcost),
  not_member(?next, ?visited),
  path(?next, ?goal, [?next|?visited], ?path, ?restcost),
  add(?stepcost, ?restcost, ?cost).

% Derived reverse links, mirroring the rule output in the Eyeling example.
edge([?b, ?a], ?cost) :-
  base_link(?a, ?b, ?cost).

% Only paths within the displayed cost bound are materialized.
path([a, f], [?path, ?cost]) :-
  path(a, f, [a], ?path, ?cost),
  le(?cost, 16).
