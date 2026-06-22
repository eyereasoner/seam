% Blocks-world planning without cut.
%
% A finite-depth planner searches for a five-move plan over five blocks.  States
% are sorted lists of on(Block, Support) facts so equality and visited-state
% checks are purely structural.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(status, 2).
materialize(plan, 2).
materialize(finalState, 2).
materialize(blockCount, 2).

% The initial and goal states are lists of on/2 facts.  Sorting successor states
% gives canonical terms for equality and visited-state checks.
initial([on(a, table), on(b, a), on(c, b), on(d, c), on(e, d)]).
goal([on(a, table), on(b, a), on(c, table), on(d, c), on(e, d)]).

block(a).
block(b).
block(c).
block(d).
block(e).

support(table, ?_state).
% move/3 chooses a clear block and a clear support; the bounded planner chains
% those legal moves while avoiding previously seen states.
support(?block, ?state) :-
  block(?block),
  member(on(?block, ?_below), ?state).

clear(?block, ?state) :-
  not(member(on(?_other, ?block), ?state)).

clear_support(table, ?_state).
clear_support(?block, ?state) :-
  block(?block),
  clear(?block, ?state).

move(?state, move(?block, ?from, ?to), ?newstate) :-
  member(on(?block, ?from), ?state),
  clear(?block, ?state),
  support(?to, ?state),
  clear_support(?to, ?state),
  neq(?block, ?to),
  neq(?from, ?to),
  select(on(?block, ?from), ?state, ?rest),
  sort([on(?block, ?to)|?rest], ?newstate).

plan(?state, ?goal, 0, ?_visited, [], ?state) :-
  eq(?state, ?goal).

plan(?state, ?goal, ?depth, ?visited, [?move|?moves], ?final) :-
  gt(?depth, 0),
  move(?state, ?move, ?next),
  not_member(?next, ?visited),
  sub(?depth, 1, ?restdepth),
  plan(?next, ?goal, ?restdepth, [?next|?visited], ?moves, ?final).

five_move_plan(?moves, ?final) :-
  initial(?start),
  goal(?goal),
  sort(?start, ?sortedstart),
  sort(?goal, ?sortedgoal),
  plan(?sortedstart, ?sortedgoal, 5, [?sortedstart], ?moves, ?final).

status(blocks_world, planned) :-
  once(five_move_plan(?_moves, ?_final)).

plan(blocks_world, ?moves) :-
  once(five_move_plan(?moves, ?_final)).

finalState(blocks_world, ?final) :-
  once(five_move_plan(?_moves, ?final)).

blockCount(blocks_world, ?count) :-
  findall(?block, block(?block), ?blocks),
  length(?blocks, ?count).
