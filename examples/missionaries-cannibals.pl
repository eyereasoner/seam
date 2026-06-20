% Missionaries-and-cannibals river crossing as guarded state-space search.
% A state records missionaries and cannibals on the left bank plus the boat side.
% crossing/3 generates only legal boat moves, and journey/4 avoids revisiting states while finding a safe path.
materialize(missionaries_cannibals_answer, 2).

move(1, 0).
move(0, 1).
move(2, 0).
move(0, 2).
move(1, 1).

bank_safe(0, _C).
bank_safe(M, C) :- gt(M, 0), ge(M, C).

state_safe(state(MLeft, CLeft, _Boat)) :-
  between(0, 3, MLeft),
  between(0, 3, CLeft),
  sub(3, MLeft, MRight),
  sub(3, CLeft, CRight),
  bank_safe(MLeft, CLeft),
  bank_safe(MRight, CRight).

crossing(state(MLeft, CLeft, left), state(NextM, NextC, right), carry(MoveM, MoveC)) :-
  move(MoveM, MoveC),
  sub(MLeft, MoveM, NextM),
  sub(CLeft, MoveC, NextC),
  state_safe(state(NextM, NextC, right)).
crossing(state(MLeft, CLeft, right), state(NextM, NextC, left), carry(MoveM, MoveC)) :-
  move(MoveM, MoveC),
  add(MLeft, MoveM, NextM),
  add(CLeft, MoveC, NextC),
  state_safe(state(NextM, NextC, left)).

journey(Goal, Goal, Visited, Visited).
journey(State, Goal, Visited, Path) :-
  crossing(State, Next, _Carry),
  not_member(Next, Visited),
  journey(Next, Goal, [Next|Visited], Path).

solution(Path) :-
  journey(state(3, 3, left), state(0, 0, right), [state(3, 3, left)], ReversePath),
  reverse(ReversePath, Path).

missionaries_cannibals_answer(first_solution, Path) :- once(solution(Path)).
missionaries_cannibals_answer(state_count, Count) :- countall(state_safe(state(_M, _C, _Boat)), Count).
missionaries_cannibals_answer(step_count, Steps) :-
  once(solution(Path)),
  length(Path, States),
  sub(States, 1, Steps).
