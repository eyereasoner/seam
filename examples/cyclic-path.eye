% Cyclic transitive closure.
%
% The graph deliberately contains the directed cycle a -> b -> c -> d -> a.  The
% recursive path/2 rule therefore has to deal with cycles while still deriving
% the reachable pairs used by the golden output.
%
% This is a compact regression-style example for active-goal handling in recursive
% graph search.

materialize(path, 2).

arc(a, b).
arc(b, c).
arc(c, d).
arc(d, a).

path(?x, ?y) :- arc(?x, ?y).
path(?x, ?z) :- arc(?x, ?y), path(?y, ?z).
