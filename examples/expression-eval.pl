% Tiny expression evaluator adapted from Eyeling's expression-eval.n3 example.
% Data: (2 * 3) + (10 - 4) = 12.
% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(result, 2).

% The expression tree is data: number/2 labels leaves, expr/4 labels
% internal operator nodes, and root/1 chooses the term to evaluate.
% Leaves are number/2 facts; internal nodes name an operator and two children.
number(n2, 2).
number(n3, 3).
number(n10, 10).
number(n4, 4).

expr(eMul, mul, n2, n3).
expr(eSub, sub, n10, n4).
expr(eAdd, add, eMul, eSub).
root(eAdd).

% Evaluation is recursive over the expression tree.
% value/2 recursively folds the tree.  Each arithmetic operator has its own
% rule so proof output shows the exact evaluation path.
value(Node, Value) :-
  number(Node, Value).

value(Node, Value) :-
  expr(Node, add, Left, Right),
  value(Left, LeftValue),
  value(Right, RightValue),
  add(LeftValue, RightValue, Value).

value(Node, Value) :-
  expr(Node, sub, Left, Right),
  value(Left, LeftValue),
  value(Right, RightValue),
  sub(LeftValue, RightValue, Value).

value(Node, Value) :-
  expr(Node, mul, Left, Right),
  value(Left, LeftValue),
  value(Right, RightValue),
  mul(LeftValue, RightValue, Value).

result(root, Value) :-
  root(Node),
  value(Node, Value).
