% Eyelet-inspired Eulerian path example using findall/3 and sort/2.
%
% The graph is undirected; edges have identifiers so the trail consumes each
% physical edge exactly once even when vertices are revisited.  The remaining
% edge-id list is the explicit search state.
materialize(oddVertices, 2).
materialize(path, 2).
materialize(edgeCount, 2).
materialize(reason, 2).

% Edge identifiers are part of the search state: the DFS removes ids, not just
% endpoints, so repeated vertex visits do not accidentally reuse an edge.
edge(e12, v1, v2).
edge(e13, v1, v3).
edge(e15, v1, v5).
edge(e16, v1, v6).
edge(e23, v2, v3).
edge(e24, v2, v4).
edge(e26, v2, v6).
edge(e34, v3, v4).
edge(e36, v3, v6).
edge(e45, v4, v5).
edge(e46, v4, v6).

% Degree parity is computed with findall/3.  The Eulerian-start rule then chooses
% an odd-degree vertex when exactly two exist, or any vertex for an Eulerian cycle.
vertex(?v) :- edge(?_e, ?v, ?_u).
vertex(?v) :- edge(?_e, ?_u, ?v).

incident(?v, ?e) :- edge(?e, ?v, ?_u).
incident(?v, ?e) :- edge(?e, ?_u, ?v).

adjacent_by_edge(?v, ?u, ?e) :- edge(?e, ?v, ?u).
adjacent_by_edge(?v, ?u, ?e) :- edge(?e, ?u, ?v).

select(?item, [?item | ?rest], ?rest).
select(?item, [?head | ?tail], [?head | ?rest]) :-
  select(?item, ?tail, ?rest).

% Eulerian paths start at an odd-degree vertex when exactly two exist.
odd_degree(?v) :-
  findall(?e, incident(?v, ?e), ?edges),
  length(?edges, ?degree),
  mod(?degree, 2, 1).

odd_vertices(?odds) :-
  findall(?v, odd_degree(?v), ?raw),
  sort(?raw, ?odds).

all_edges(?edges) :-
  findall(?e, edge(?e, ?_a, ?_b), ?raw),
  sort(?raw, ?edges).

vertices(?vertices) :-
  findall(?v, vertex(?v), ?raw),
  sort(?raw, ?vertices).

eulerian_start(?start) :-
  odd_vertices([?start, ?_end]).
eulerian_start(?start) :-
  odd_vertices([]),
  vertices([?start | ?_rest]).

eulerian_path(?path) :-
  eulerian_start(?start),
  all_edges(?edges),
  dfs_euler(?start, [?start], ?edges, ?reversedpath),
  reverse(?reversedpath, ?path).

% Depth-first search consumes the remaining edge-id list one edge at a time.
dfs_euler(?_current, ?path, [], ?path).
dfs_euler(?current, ?visited, ?remaining, ?path) :-
  adjacent_by_edge(?current, ?next, ?edge),
  select(?edge, ?remaining, ?newremaining),
  dfs_euler(?next, [?next | ?visited], ?newremaining, ?path).

oddVertices(eulerian_path_case, ?odds) :-
  odd_vertices(?odds).

path(eulerian_path_case, ?path) :-
  once(eulerian_path(?path)).

edgeCount(eulerian_path_case, ?count) :-
  all_edges(?edges),
  length(?edges, ?count).

reason(eulerian_path_case, "findall collects graph structure and sort canonicalizes vertices and edges").
