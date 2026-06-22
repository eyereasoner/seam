% Tiny expression evaluator adapted from Eyeling's expression-eval.n3 example.
%
% The expression tree represents (2 * 3) + (10 - 4).  value/2 recursively folds
% the tree, so proof output shows how the final result 12 is assembled from
% smaller arithmetic subexpressions.
materialize(result, 2).

% The expression tree is data: number/2 labels leaves, expr/4 labels internal
% operator nodes, and root/1 chooses the term to evaluate.
number(n2, 2).
number(n3, 3).
number(n10, 10).
number(n4, 4).

expr(eMul, mul, n2, n3).
expr(eSub, sub, n10, n4).
expr(eAdd, add, eMul, eSub).
root(eAdd).

% Each arithmetic operator has its own rule, which makes the proof tree mirror
% the shape of the expression tree.
value(?node, ?value) :-
  number(?node, ?value).

value(?node, ?value) :-
  expr(?node, add, ?left, ?right),
  value(?left, ?leftvalue),
  value(?right, ?rightvalue),
  add(?leftvalue, ?rightvalue, ?value).

value(?node, ?value) :-
  expr(?node, sub, ?left, ?right),
  value(?left, ?leftvalue),
  value(?right, ?rightvalue),
  sub(?leftvalue, ?rightvalue, ?value).

value(?node, ?value) :-
  expr(?node, mul, ?left, ?right),
  value(?left, ?leftvalue),
  value(?right, ?rightvalue),
  mul(?leftvalue, ?rightvalue, ?value).

result(root, ?value) :-
  root(?node),
  value(?node, ?value).
