% Matrix multiplication and non-commutativity.
%
% The original matrix example contains a larger matrix library.  This compact
% Eyelang case keeps the core operation visible: multiply two 2x2 matrices and
% show that, in general, A*B is not the same matrix as B*A.

materialize(matrix_result, 2).

matrix_a([[1, 2], [0, 1]]).
matrix_b([[1, 0], [3, 1]]).

dot2([?x1, ?x2], [?y1, ?y2], ?r) :-
  mul(?x1, ?y1, ?p1),
  mul(?x2, ?y2, ?p2),
  add(?p1, ?p2, ?r).

transpose2([[?a, ?b], [?c, ?d]], [[?a, ?c], [?b, ?d]]).

row_times_matrix(?row, ?matrix, [?r1, ?r2]) :-
  transpose2(?matrix, [?col1, ?col2]),
  dot2(?row, ?col1, ?r1),
  dot2(?row, ?col2, ?r2).

matrix_mul([?row1, ?row2], ?matrix, [?out1, ?out2]) :-
  row_times_matrix(?row1, ?matrix, ?out1),
  row_times_matrix(?row2, ?matrix, ?out2).

matrix_result(ab, ?ab) :-
  matrix_a(?a),
  matrix_b(?b),
  matrix_mul(?a, ?b, ?ab).

matrix_result(ba, ?ba) :-
  matrix_a(?a),
  matrix_b(?b),
  matrix_mul(?b, ?a, ?ba).

matrix_result(commutative, false) :-
  matrix_a(?a),
  matrix_b(?b),
  matrix_mul(?a, ?b, ?ab),
  matrix_mul(?b, ?a, ?ba),
  neq(?ab, ?ba).
