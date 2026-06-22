% Universal Turing machine example adapted from Eyelet's input/turing.eye.
%
% The machine below adds 1 to a binary number represented as a list of bits.
% A tape is split into a reversed left side, current cell, and right side; move/7
% updates that zipper representation.  The blank tape symbol is #.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(input, 2).
materialize(output, 2).
materialize(addsOne, 2).

% compute/2 initializes the tape and starts from the machine's start state.
compute([], ?outtape) :-
  start(?_machine, ?i),
  find(?i, [], #, [], ?outtape).

compute([?head|?tail], ?outtape) :-
  start(?_machine, ?i),
  find(?i, [], ?head, ?tail, ?outtape).

% find/5 executes one transition, moves the head, and either halts or recurses.
find(?state, ?left, ?cell, ?right, ?outtape) :-
  t([?state, ?cell, ?write, ?move], ?next),
  move(?move, ?left, ?write, ?right, ?a, ?b, ?c),
  continue(?next, ?a, ?b, ?c, ?outtape).

continue(halt, ?left, ?cell, ?right, ?outtape) :-
  rever(?left, ?r),
  append(?r, [?cell|?right], ?outtape).

continue(?state, ?left, ?cell, ?right, ?outtape) :-
  find(?state, ?left, ?cell, ?right, ?outtape).

% Head movement defines the tape zipper update, including blank extension.
move(l, [], ?cell, ?right, [], #, [?cell|?right]).
move(l, [?head|?tail], ?cell, ?right, ?tail, ?head, [?cell|?right]).
move(s, ?left, ?cell, ?right, ?left, ?cell, ?right).
move(r, ?left, ?cell, [], [?cell|?left], #, []).
move(r, ?left, ?cell, [?head|?tail], [?cell|?left], ?head, ?tail).

rever([], []).
rever([?a|?b], ?c) :-
  rever(?b, ?d),
  append(?d, [?a], ?c).

% A Turing machine to add 1 to a binary number.
start(add1, 0).
t([0, 0, 0, r], 0).
t([0, 1, 1, r], 0).
t([0, #, #, l], 1).
t([1, 0, 1, s], halt).
t([1, 1, 0, l], 1).
t([1, #, 1, s], halt).

case(case1, [1, 0, 1, 0, 0, 1]).
case(case2, [1, 0, 1, 1, 1, 1]).
case(case3, [1, 1, 1, 1, 1, 1]).
case(case4, []).

input(?case, ?intape) :-
  case(?case, ?intape).

output(?case, ?outtape) :-
  case(?case, ?intape),
  compute(?intape, ?outtape).

addsOne(?case, true) :-
  case(?case, ?intape),
  compute(?intape, ?_outtape).
