% Missionaries-and-cannibals river crossing as guarded state-space search.
%
% A state records missionaries and cannibals on the left bank plus the boat side.
% crossing/3 applies one legal boat load and state_safe/1 checks both banks.
% journey/4 carries a visited list to avoid loops in the finite state graph.
materialize(missionaries_cannibals_answer, 2).

% Boat loads: one or two passengers, with at least one passenger per crossing.
move(1, 0).
move(0, 1).
move(2, 0).
move(0, 2).
move(1, 1).

% A bank is safe if there are no missionaries or missionaries are not outnumbered.
bank_safe(0, ?_c).
bank_safe(?m, ?c) :- gt(?m, 0), ge(?m, ?c).

state_safe(state(?mleft, ?cleft, ?_boat)) :-
  between(0, 3, ?mleft),
  between(0, 3, ?cleft),
  sub(3, ?mleft, ?mright),
  sub(3, ?cleft, ?cright),
  bank_safe(?mleft, ?cleft),
  bank_safe(?mright, ?cright).

crossing(state(?mleft, ?cleft, left), state(?nextm, ?nextc, right), carry(?movem, ?movec)) :-
  move(?movem, ?movec),
  sub(?mleft, ?movem, ?nextm),
  sub(?cleft, ?movec, ?nextc),
  state_safe(state(?nextm, ?nextc, right)).
crossing(state(?mleft, ?cleft, right), state(?nextm, ?nextc, left), carry(?movem, ?movec)) :-
  move(?movem, ?movec),
  add(?mleft, ?movem, ?nextm),
  add(?cleft, ?movec, ?nextc),
  state_safe(state(?nextm, ?nextc, left)).

journey(?goal, ?goal, ?visited, ?visited).
journey(?state, ?goal, ?visited, ?path) :-
  crossing(?state, ?next, ?_carry),
  not_member(?next, ?visited),
  journey(?next, ?goal, [?next|?visited], ?path).

solution(?path) :-
  journey(state(3, 3, left), state(0, 0, right), [state(3, 3, left)], ?reversepath),
  reverse(?reversepath, ?path).

missionaries_cannibals_answer(first_solution, ?path) :- once(solution(?path)).
missionaries_cannibals_answer(state_count, ?count) :- countall(state_safe(state(?_m, ?_c, ?_boat)), ?count).
missionaries_cannibals_answer(step_count, ?steps) :-
  once(solution(?path)),
  length(?path, ?states),
  sub(?states, 1, ?steps).
