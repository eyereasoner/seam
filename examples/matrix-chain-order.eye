% Matrix-chain multiplication order by tabled interval dynamic programming.
%
% cost(I, J, Cost) is the minimum scalar multiplication cost for matrices I..J.
% best_split/3 records which split obtains that cost, and parenthesization/3
% reconstructs one optimal multiplication tree.
materialize(matrix_chain_answer, 2).

table(cost, 3).

% Matrix dimensions are stored as adjacent p-values: matrix I has dimensions P_{I-1} x P_I.

% Dimensions for the CLRS-style chain: A1 is 30x35, A2 is 35x15, and so on.
% The dim/2 facts store boundary dimensions, so multiplying Ai..Ak by A(k+1)..Aj
% costs dim(I-1) * dim(K) * dim(J).
dim(0, 30).
dim(1, 35).
dim(2, 15).
dim(3, 5).
dim(4, 10).
dim(5, 20).
dim(6, 25).

matrix_count(6).

cost(?i, ?i, 0) :- matrix_count(?n), between(1, ?n, ?i).
cost(?i, ?j, ?cost) :-
  lt(?i, ?j),
  aggregate_min(?splitcost, ?k,
    (between(?i, ?j, ?k),
     lt(?k, ?j),
     cost(?i, ?k, ?left),
     add(?k, 1, ?k1),
     cost(?k1, ?j, ?right),
     sub(?i, 1, ?i0),
     dim(?i0, ?rows),
     dim(?k, ?shared),
     dim(?j, ?cols),
     mul(?rows, ?shared, ?first),
     mul(?first, ?cols, ?multcost),
     add(?left, ?right, ?partial),
     add(?partial, ?multcost, ?splitcost)),
    ?cost, ?_bestk).

best_split(?i, ?j, ?k) :-
  lt(?i, ?j),
  aggregate_min(?splitcost, ?k,
    (between(?i, ?j, ?k),
     lt(?k, ?j),
     cost(?i, ?k, ?left),
     add(?k, 1, ?k1),
     cost(?k1, ?j, ?right),
     sub(?i, 1, ?i0),
     dim(?i0, ?rows),
     dim(?k, ?shared),
     dim(?j, ?cols),
     mul(?rows, ?shared, ?first),
     mul(?first, ?cols, ?multcost),
     add(?left, ?right, ?partial),
     add(?partial, ?multcost, ?splitcost)),
    ?_cost, ?k).

parenthesization(?i, ?i, matrix(?i)).
parenthesization(?i, ?j, product(?lefttree, ?righttree)) :-
  lt(?i, ?j),
  best_split(?i, ?j, ?k),
  add(?k, 1, ?k1),
  parenthesization(?i, ?k, ?lefttree),
  parenthesization(?k1, ?j, ?righttree).

matrix_chain_answer(min_cost, ?cost) :- cost(1, 6, ?cost).
matrix_chain_answer(best_split_1_6, ?k) :- best_split(1, 6, ?k).
matrix_chain_answer(best_order, ?tree) :- parenthesization(1, 6, ?tree).
subproblem(?i, ?j, ?cost) :-
  matrix_count(?n),
  between(1, ?n, ?i),
  between(?i, ?n, ?j),
  cost(?i, ?j, ?cost).

matrix_chain_answer(subproblem_count, ?count) :- countall(subproblem(?_i, ?_j, ?_cost), ?count).
