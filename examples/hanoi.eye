% Towers of Hanoi adapted from Eyeling hanoi.n3.
% hanoi/5 recursively builds the move list by moving N-1 disks aside, moving the
% largest disk, then moving N-1 disks onto the target peg.  The size-3 answer is
% small enough for a readable golden output while still exercising list append.

materialize(answer, 2).

table(hanoi, 5).

hanoi(0, ?_from, ?_to, ?_via, []).
hanoi(?n, ?from, ?to, ?via, ?moves) :-
  gt(?n, 0),
  sub(?n, 1, ?n1),
  hanoi(?n1, ?from, ?via, ?to, ?before),
  hanoi(?n1, ?via, ?to, ?from, ?after),
  append(?before, [[?from, ?to]|?after], ?moves).

answer(3, ?moves) :-
  hanoi(3, left, right, center, ?moves).
