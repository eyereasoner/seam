% Hamiltonian path, adapted from Eyelet's input/hamiltonian-path.eye.
%
% The graph is the same six-vertex undirected graph.  eyelang spells the finite
% vertex set directly and derives every path that visits each vertex exactly
% once.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(hasHamiltonianPath, 2).
materialize(hamiltonianPath, 2).

% The finite six-vertex graph is small enough to search directly.  adjacent/2
% is tabled because every candidate path repeatedly asks the same edge tests.
table(adjacent, 2).

edge(v1, v2).
edge(v1, v3).
edge(v1, v5).
edge(v1, v6).
edge(v2, v3).
edge(v2, v4).
edge(v2, v6).
edge(v3, v4).
edge(v3, v6).
edge(v4, v5).
edge(v4, v6).

% hamiltonian_path/1 is intentionally unrolled to six positions: each next
% vertex must be adjacent to the previous one and absent from the prefix.
adjacent(?v, ?u) :- edge(?v, ?u).
adjacent(?v, ?u) :- edge(?u, ?v).

vertex(v1).
vertex(v2).
vertex(v3).
vertex(v4).
vertex(v5).
vertex(v6).

hamiltonian_path([?a, ?b, ?c, ?d, ?e, ?f]) :-
  vertex(?a),
  vertex(?b), adjacent(?a, ?b), not_member(?b, [?a]),
  vertex(?c), adjacent(?b, ?c), not_member(?c, [?a, ?b]),
  vertex(?d), adjacent(?c, ?d), not_member(?d, [?a, ?b, ?c]),
  vertex(?e), adjacent(?d, ?e), not_member(?e, [?a, ?b, ?c, ?d]),
  vertex(?f), adjacent(?e, ?f), not_member(?f, [?a, ?b, ?c, ?d, ?e]).

hasHamiltonianPath(graph, true) :-
  hamiltonian_path(?_path).

hamiltonianPath(graph, ?path) :-
  hamiltonian_path(?path).
