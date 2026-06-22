% Fibonacci numbers by fast doubling.
%
% The public fibonacci/2 relation is bounded by fib_case/1 facts, while fib_pair/3
% computes F(N) and F(N+1) together.  This exposes a logarithmic recursive
% algorithm in a small relational program instead of enumerating all predecessors.
%
% Memoization is important for the large cases: several requested Fibonacci
% numbers reuse the same half-size fib_pair/3 subproblems.
materialize(fibonacci, 2).

% fib_case/1 bounds the public queries, while fib_pair/3 implements the
% fast-doubling recurrence F(2n), F(2n+1) over arbitrary-size integers.
table(fib_pair, 3).

% BigInt Fibonacci via fast doubling, implemented in Prolog using generic
% decimal add/sub/mul built-ins.  The result predicate follows Eyeling's
% fibonacci.n3 output shape: N fibonacci Value.
fib_case(0).
fib_case(1).
fib_case(10).
fib_case(100).
fib_case(1000).
fib_case(10000).

% The even and odd fib_pair/3 clauses share the same half-size recursive call;
% memoization makes repeated large cases reuse those subproblems.
fib(?n, ?value) :- fib_pair(?n, ?value, ?_next).

fib_pair(0, 0, 1).
fib_pair(?n, ?f, ?g) :-
  gt(?n, 0),
  div(?n, 2, ?half),
  fib_pair(?half, ?a, ?b),
  mul(?b, 2, ?twob),
  sub(?twob, ?a, ?twobminusa),
  mul(?a, ?twobminusa, ?c),
  mul(?a, ?a, ?aa),
  mul(?b, ?b, ?bb),
  add(?aa, ?bb, ?d),
  mod(?n, 2, 0),
  eq(?f, ?c),
  eq(?g, ?d).
fib_pair(?n, ?f, ?g) :-
  gt(?n, 0),
  div(?n, 2, ?half),
  fib_pair(?half, ?a, ?b),
  mul(?b, 2, ?twob),
  sub(?twob, ?a, ?twobminusa),
  mul(?a, ?twobminusa, ?c),
  mul(?a, ?a, ?aa),
  mul(?b, ?b, ?bb),
  add(?aa, ?bb, ?d),
  mod(?n, 2, 1),
  add(?c, ?d, ?next),
  eq(?f, ?d),
  eq(?g, ?next).

fibonacci(?n, ?value) :-
  fib_case(?n),
  fib(?n, ?value).
