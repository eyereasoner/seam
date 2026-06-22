% Eyelet-inspired Dijkstra example using findall/3 and sort/2.
% The priority queue is represented as sorted list entries [Cost, Node | Path].
% Each expansion collects unvisited neighbors with findall/3, appends them to
% the frontier, and uses sort/2 so the cheapest frontier entry is processed next.

materialize(shortestPath, 2).
materialize(cost, 2).
materialize(reason, 2).

% Weighted undirected graph; the symmetric edge rule below adds reverse arcs.
edge(a, b, 4).
edge(a, c, 2).
edge(b, c, 1).
edge(b, d, 5).
edge(c, d, 8).
edge(c, e, 10).
edge(d, e, 2).
edge(d, f, 6).
edge(e, f, 3).
edge(?a, ?b, ?cost) :- edge(?b, ?a, ?cost).

% The frontier is represented as [Cost, Node | ReversePath] entries.
dijkstra(?start, ?goal, ?path, ?cost) :-
  dijkstra_queue([[0, ?start]], ?goal, [], ?revpath, ?cost),
  reverse(?revpath, ?path).

dijkstra_queue([[?cost, ?goal | ?path] | ?_queue], ?goal, ?_visited, [?goal | ?path], ?cost).
dijkstra_queue([[?cost, ?node | ?path] | ?queue], ?goal, ?visited, ?resultpath, ?resultcost) :-
  % Expand all unvisited neighbors, then sort so the cheapest frontier wins.
  findall([?newcost, ?neighbor, ?node | ?path],
    (edge(?node, ?neighbor, ?weight), not(member(?neighbor, ?visited)), add(?cost, ?weight, ?newcost)),
    ?neighbors),
  append(?queue, ?neighbors, ?newqueue),
  sort(?newqueue, ?sortedqueue),
  dijkstra_queue(?sortedqueue, ?goal, [?node | ?visited], ?resultpath, ?resultcost).

shortestPath(dijkstra_findall_sort, ?path) :-
  once(dijkstra(a, f, ?path, ?_cost)).

cost(dijkstra_findall_sort, ?cost) :-
  once(dijkstra(a, f, ?_path, ?cost)).

reason(dijkstra_findall_sort, "frontier candidates are collected with findall and ordered with sort").
