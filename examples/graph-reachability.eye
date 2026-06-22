% Graph reachability example adapted from Eyelet input/graph-reachability.eye.
% The recursive search carries a Visited list and rejects already-seen nodes with
% not(member(...)).  This keeps reachability finite and also lets the example
% derive explicit not_reachable/2 evidence for a negative test case.

materialize(reachable, 2).
materialize(not_reachable, 2).

edge(a, b).
edge(a, c).
edge(b, d).
edge(c, e).
edge(d, f).
edge(e, f).
edge(f, g).

reachable(?node, ?node, ?_visited).
reachable(?start, ?goal, ?visited) :-
  edge(?start, ?next),
  not(member(?next, ?visited)),
  reachable(?next, ?goal, [?next|?visited]).

is_reachable(?start, ?goal) :-
  reachable(?start, ?goal, [?start]).

reachable(reachability_case, path(a, f)) :-
  is_reachable(a, f).

reachable(reachability_case, path(c, g)) :-
  is_reachable(c, g).

not_reachable(reachability_case, path(b, e)) :-
  not(is_reachable(b, e)).
