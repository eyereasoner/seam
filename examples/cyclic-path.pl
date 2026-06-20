% Cyclic transitive closure.
% The graph deliberately contains a directed cycle a -> b -> c -> d -> a.  This
% tests that recursive path/2 search can derive reachable pairs without getting
% stuck repeatedly expanding the same active subgoal.

materialize(path, 2).

arc(a, b).
arc(b, c).
arc(c, d).
arc(d, a).

path(X, Y) :- arc(X, Y).
path(X, Z) :- arc(X, Y), path(Y, Z).
