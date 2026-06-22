% Gray-code counter adapted from Eyeling gray-code-counter.n3.
% Boolean gates are represented as truth-table facts.  The circuit rules compose
% those gates into next-state logic for three flip-flops, and testgcc/3 runs the
% counter over a finite clock sequence.

materialize(isgcc, 2).

% Boolean gates are truth tables; the circuit rules compose them.
and(0, 0, 0). and(0, 1, 0). and(1, 0, 0). and(1, 1, 1).
or(0, 0, 0).  or(0, 1, 1).  or(1, 0, 1).  or(1, 1, 1).
inv(0, 1). inv(1, 0).

dff(?d, 0, ?q, ?q).
dff(?d, 1, ?_q, ?d).

neta(?a, ?b, ?q) :-
  and(?a, ?b, ?t1),
  inv(?a, ?na),
  inv(?b, ?nb),
  and(?na, ?nb, ?t2),
  or(?t1, ?t2, ?q).

netb(?a, ?b, ?c, ?q1, ?q2) :-
  and(?a, ?c, ?t1),
  inv(?c, ?nc),
  and(?b, ?nc, ?t2),
  inv(?a, ?na),
  and(?na, ?c, ?t3),
  or(?t1, ?t2, ?q1),
  or(?t2, ?t3, ?q2).

% One clock step computes D inputs, then updates the three flip-flops.
gcc(?c, [?qa, ?qb, ?qc], [?za, ?zb, ?zc]) :-
  netb(?qa, ?qb, ?qc, ?d1, ?d2),
  neta(?qa, ?qb, ?d3),
  dff(?d1, ?c, ?qa, ?za),
  dff(?d2, ?c, ?qb, ?zb),
  dff(?d3, ?c, ?qc, ?zc).

% testgcc/3 runs the circuit over a list of clock inputs.
testgcc([], ?_state, []).
testgcc([?c|?cs], ?state, [?next|?rest]) :-
  gcc(?c, ?state, ?next),
  testgcc(?cs, ?next, ?rest).

isgcc([[1, 1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 0]], ?states) :-
  testgcc([1, 1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 0], ?states).
