% Wolf, goat and cabbage puzzle, adapted from Eyelet's
% input/wolf-goat-cabbage.eye.
%
% A configuration is [man, wolf, goat, cabbage], where each item is on the west
% bank w or east bank e.  The recursive search keeps a visited list so eyelang
% explores the finite state space without looping.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(solution, 2).
materialize(solved, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
table(solve, 4).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
solution(?moves) :-
  solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], ?moves),
  length(?moves, 7).

solve(?config, ?config, ?_visited, []).

solve(?config, ?goal, ?visited, [?move|?rest]) :-
  move(?config, ?move, ?nextconfig),
  safe(?nextconfig),
  not_member(?nextconfig, ?visited),
  solve(?nextconfig, ?goal, [?nextconfig|?visited], ?rest).

% Each move transforms one configuration into another.
move([?x, ?x, ?goat, ?cabbage], wolf, [?y, ?y, ?goat, ?cabbage]) :-
  change(?x, ?y).

move([?x, ?wolf, ?x, ?cabbage], goat, [?y, ?wolf, ?y, ?cabbage]) :-
  change(?x, ?y).

move([?x, ?wolf, ?goat, ?x], cabbage, [?y, ?wolf, ?goat, ?y]) :-
  change(?x, ?y).

move([?x, ?wolf, ?goat, ?cabbage], nothing, [?y, ?wolf, ?goat, ?cabbage]) :-
  change(?x, ?y).

change(e, w).
change(w, e).

% Safe if the goat is not left alone with the wolf or cabbage without the man.
safe([?man, ?wolf, ?goat, ?cabbage]) :-
  one_eq(?man, ?goat, ?wolf),
  one_eq(?man, ?goat, ?cabbage).

one_eq(?x, ?x, ?).
one_eq(?x, ?, ?x).

solution(puzzle, ?moves) :-
  solution(?moves).

solved(puzzle, true) :-
  solution(?_moves).
