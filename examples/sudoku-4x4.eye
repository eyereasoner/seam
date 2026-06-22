% Compact 4x4 Sudoku search with row permutations and column/box constraints.
%
% The givens are baked into row1/1 ... row4/1, so each candidate row is already
% a permutation of 1..4.  sudoku_solution/1 then checks the remaining columns
% and 2x2 boxes, which keeps the example clear and playground-friendly.
materialize(sudoku_answer, 2).

perm([], []).
perm(?items, [?x|?rest]) :-
  select(?x, ?items, ?remaining),
  perm(?remaining, ?rest).

% distinct/1 is the reusable all-different constraint.
distinct([]).
distinct([?x|?xs]) :-
  not_member(?x, ?xs),
  distinct(?xs).

row1([1, ?b, ?c, 4]) :- perm([1, 2, 3, 4], [1, ?b, ?c, 4]).
row2([?a, 4, 1, ?d]) :- perm([1, 2, 3, 4], [?a, 4, 1, ?d]).
row3([?b, 1, 4, ?c]) :- perm([1, 2, 3, 4], [?b, 1, 4, ?c]).
row4([4, ?c, ?b, 1]) :- perm([1, 2, 3, 4], [4, ?c, ?b, 1]).

column([?r1, ?r2, ?r3, ?r4], ?index, [?a, ?b, ?c, ?d]) :-
  nth0(?index, ?r1, ?a),
  nth0(?index, ?r2, ?b),
  nth0(?index, ?r3, ?c),
  nth0(?index, ?r4, ?d).

% The four boxes are extracted as lists, then passed through distinct/1.
boxes([?r1, ?r2, ?r3, ?r4], [?box1, ?box2, ?box3, ?box4]) :-
  nth0(0, ?r1, ?a), nth0(1, ?r1, ?b), nth0(0, ?r2, ?c), nth0(1, ?r2, ?d),
  eq(?box1, [?a, ?b, ?c, ?d]),
  nth0(2, ?r1, ?e), nth0(3, ?r1, ?f), nth0(2, ?r2, ?g), nth0(3, ?r2, ?h),
  eq(?box2, [?e, ?f, ?g, ?h]),
  nth0(0, ?r3, ?i), nth0(1, ?r3, ?j), nth0(0, ?r4, ?k), nth0(1, ?r4, ?l),
  eq(?box3, [?i, ?j, ?k, ?l]),
  nth0(2, ?r3, ?m), nth0(3, ?r3, ?n), nth0(2, ?r4, ?o), nth0(3, ?r4, ?p),
  eq(?box4, [?m, ?n, ?o, ?p]).

sudoku_solution([?r1, ?r2, ?r3, ?r4]) :-
  row1(?r1),
  row2(?r2),
  row3(?r3),
  row4(?r4),
  column([?r1, ?r2, ?r3, ?r4], 0, ?c0), distinct(?c0),
  column([?r1, ?r2, ?r3, ?r4], 1, ?c1), distinct(?c1),
  column([?r1, ?r2, ?r3, ?r4], 2, ?c2), distinct(?c2),
  column([?r1, ?r2, ?r3, ?r4], 3, ?c3), distinct(?c3),
  boxes([?r1, ?r2, ?r3, ?r4], [?b1, ?b2, ?b3, ?b4]),
  distinct(?b1), distinct(?b2), distinct(?b3), distinct(?b4).

sudoku_answer(solution, ?grid) :- once(sudoku_solution(?grid)).
sudoku_answer(solution_count, ?count) :- countall(sudoku_solution(?_grid), ?count).
