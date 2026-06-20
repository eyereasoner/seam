% N-queens search for the 8x8 board.
% This example enumerates all row permutations and filters diagonal attacks.
materialize(n_queens_answer, 2).

% Cache diagonal checks; the same row/distance/suffix states recur across
% many candidate permutations during the 8-queens search.
memoize(no_diagonal_attack, 3).

perm([], []).
perm(Items, [X|Rest]) :-
  select(X, Items, Remaining),
  perm(Remaining, Rest).

safe_rows([]).
safe_rows([Row|Rest]) :-
  no_diagonal_attack(Row, 1, Rest),
  safe_rows(Rest).

no_diagonal_attack(_Row, _Distance, []).
no_diagonal_attack(Row, Distance, [Other|Rest]) :-
  sub(Row, Other, Delta),
  abs(Delta, AbsDelta),
  neq(AbsDelta, Distance),
  add(Distance, 1, NextDistance),
  no_diagonal_attack(Row, NextDistance, Rest).

queen_solution(Rows) :-
  perm([1, 2, 3, 4, 5, 6, 7, 8], Rows),
  safe_rows(Rows).

n_queens_answer(first_solution, Rows) :- once(queen_solution(Rows)).
