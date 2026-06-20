% Matrix-chain multiplication order by memoized interval dynamic programming.
% cost(I, J, Cost) is the minimum scalar multiplication cost for matrices I..J.
materialize(matrix_chain_answer, 2).

memoize(cost, 3).

% Dimensions for the CLRS-style chain: A1 is 30x35, A2 is 35x15, ...
dim(0, 30).
dim(1, 35).
dim(2, 15).
dim(3, 5).
dim(4, 10).
dim(5, 20).
dim(6, 25).

matrix_count(6).

cost(I, I, 0) :- matrix_count(N), between(1, N, I).
cost(I, J, Cost) :-
  lt(I, J),
  aggregate_min(SplitCost, K,
    (between(I, J, K),
     lt(K, J),
     cost(I, K, Left),
     add(K, 1, K1),
     cost(K1, J, Right),
     sub(I, 1, I0),
     dim(I0, Rows),
     dim(K, Shared),
     dim(J, Cols),
     mul(Rows, Shared, First),
     mul(First, Cols, MultCost),
     add(Left, Right, Partial),
     add(Partial, MultCost, SplitCost)),
    Cost, _BestK).

best_split(I, J, K) :-
  lt(I, J),
  aggregate_min(SplitCost, K,
    (between(I, J, K),
     lt(K, J),
     cost(I, K, Left),
     add(K, 1, K1),
     cost(K1, J, Right),
     sub(I, 1, I0),
     dim(I0, Rows),
     dim(K, Shared),
     dim(J, Cols),
     mul(Rows, Shared, First),
     mul(First, Cols, MultCost),
     add(Left, Right, Partial),
     add(Partial, MultCost, SplitCost)),
    _Cost, K).

parenthesization(I, I, matrix(I)).
parenthesization(I, J, product(LeftTree, RightTree)) :-
  lt(I, J),
  best_split(I, J, K),
  add(K, 1, K1),
  parenthesization(I, K, LeftTree),
  parenthesization(K1, J, RightTree).

matrix_chain_answer(min_cost, Cost) :- cost(1, 6, Cost).
matrix_chain_answer(best_split_1_6, K) :- best_split(1, 6, K).
matrix_chain_answer(best_order, Tree) :- parenthesization(1, 6, Tree).
subproblem(I, J, Cost) :-
  matrix_count(N),
  between(1, N, I),
  between(I, N, J),
  cost(I, J, Cost).

matrix_chain_answer(subproblem_count, Count) :- countall(subproblem(_I, _J, _Cost), Count).
