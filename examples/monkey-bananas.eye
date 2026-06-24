% Monkey and bananas planning problem, adapted from Eyelet's
% input/monkey-bananas.eye.
%
% A state is [bananas_location, monkey_location, box_location, on_box,
% has_bananas].  The selected output searches bounded move lists and derives successful
% plans.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(plan, 2).
materialize(solved, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
table(reachable, 3).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
plan(?moves) :-
  candidate_plan(?moves),
  initial_state(?i),
  goal_state(?g),
  reachable(?i, ?moves, ?g).

candidate_plan([?, ?, ?]).
candidate_plan([?, ?, ?, ?]).
candidate_plan([?, ?, ?, ?, ?]).

reachable(?s, [], ?s).
reachable(?s1, [?m|?l], ?s3) :-
  legal_move(?s1, ?m, ?s2),
  reachable(?s2, ?l, ?s3).

initial_state([loc1, loc2, loc3, n, n]).
goal_state([?, ?, ?, ?, y]).

legal_move([?b, ?m, ?m, n, ?h], climb_on, [?b, ?m, ?m, y, ?h]).
legal_move([?b, ?m, ?m, y, ?h], climb_off, [?b, ?m, ?m, n, ?h]).
legal_move([?b, ?b, ?b, y, n], grab, [?b, ?b, ?b, y, y]).
legal_move([?b, ?m, ?m, n, ?h], push(?x), [?b, ?x, ?x, n, ?h]) :-
  member(?x, [loc1, loc2, loc3]),
  neq(?x, ?m).
legal_move([?b, ?m, ?l, n, ?h], go(?x), [?b, ?x, ?l, n, ?h]) :-
  member(?x, [loc1, loc2, loc3]),
  neq(?x, ?m).

plan(monkeyBananas, ?moves) :- plan(?moves).
solved(monkeyBananas, true) :- plan(?_moves).
