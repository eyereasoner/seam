% N-queens search for the 8x8 board.
%
% A solution is represented as a list of row numbers, one per column.  Using a
% permutation enforces one queen per row automatically; safe_rows/1 only has to
% reject diagonal attacks.
materialize(n_queens_answer, 2).

% Cache diagonal checks; the same row/distance/suffix states recur across many
% candidate permutations during the 8-queens search.  The example asks only for
% the first solution with once/1, keeping it playground-friendly.
table(no_diagonal_attack, 3).

perm([], []).
perm(?items, [?x|?rest]) :-
  select(?x, ?items, ?remaining),
  perm(?remaining, ?rest).

safe_rows([]).
safe_rows([?row|?rest]) :-
  no_diagonal_attack(?row, 1, ?rest),
  safe_rows(?rest).

no_diagonal_attack(?_row, ?_distance, []).
no_diagonal_attack(?row, ?distance, [?other|?rest]) :-
  sub(?row, ?other, ?delta),
  abs(?delta, ?absdelta),
  neq(?absdelta, ?distance),
  add(?distance, 1, ?nextdistance),
  no_diagonal_attack(?row, ?nextdistance, ?rest).

queen_solution(?rows) :-
  perm([1, 2, 3, 4, 5, 6, 7, 8], ?rows),
  safe_rows(?rows).

n_queens_answer(first_solution, ?rows) :- once(queen_solution(?rows)).
