% Ackermann-style hyperoperation benchmark adapted from Eyeling ackermann.n3.
% The public ackermann/2 answers are small, but the helper relation exercises
% deeply nested arithmetic recursion: hyper/4 encodes successor, addition,
% multiplication, exponentiation, and then the Ackermann-style offset
% ackermann(X, Y) = hyper(X, Y + 3, 2) - 3.
% Keeping the selected inputs explicit avoids unbounded generation while still
% testing the solver's recursive numeric workload.

materialize(ackermann, 2).

ackermann(?x, ?y, ?a) :-
  add(?y, 3, ?b),
  hyper(?x, ?b, 2, ?c),
  sub(?c, 3, ?a).

% Successor, addition, multiplication, and exponentiation levels.
hyper(0, ?y, ?_z, ?a) :- add(?y, 1, ?a).
hyper(1, ?y, ?z, ?a) :- add(?y, ?z, ?a).
hyper(2, ?y, ?z, ?a) :- mul(?y, ?z, ?a).
hyper(3, ?y, ?z, ?a) :- pow(?z, ?y, ?a).

% Higher levels recurse over the previous hyperoperation.
hyper(?x, 0, ?_z, 1) :- gt(?x, 3).
hyper(?x, ?y, ?z, ?a) :-
  gt(?x, 3),
  neq(?y, 0),
  sub(?y, 1, ?b),
  hyper(?x, ?b, ?z, ?c),
  sub(?x, 1, ?d),
  hyper(?d, ?c, ?z, ?a).

ack_case(0, 0).
ack_case(0, 6).
ack_case(1, 2).
ack_case(1, 7).
ack_case(2, 2).
ack_case(2, 9).
ack_case(3, 4).
ack_case(3, 1000).
ack_case(4, 0).
ack_case(4, 1).
ack_case(4, 2).
ack_case(5, 0).

ackermann([?x, ?y], ?a) :-
  ack_case(?x, ?y),
  ackermann(?x, ?y, ?a).
