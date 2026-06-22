% Vector dot product, Euclidean norm, and cosine similarity.
%
% Recursive list folds compute the dot product and squared-length sums.  The
% public cosineSimilarity/2 report then combines those folds as
% dot(A,B)/(norm(A)*norm(B)) for a named vector pair.
%
% The example keeps vectors as ordinary Eyelang lists, so it doubles as a compact
% demonstration of numeric recursion over list structure.

materialize(dotProduct, 2).
materialize(normA, 2).
materialize(normB, 2).
materialize(cosineSimilarity, 2).

% Two named vectors form the single cosine-similarity case.
vector(pair1, a, [1.0, 2.0, 3.0]).
vector(pair1, b, [4.0, -5.0, 6.0]).

% Recursive list folds compute dot products and sums of squares.
dot([], [], 0.0).
dot([?a|?as], [?b|?bs], ?dot) :-
  mul(?a, ?b, ?product),
  dot(?as, ?bs, ?rest),
  add(?product, ?rest, ?dot).

sum_squares([], 0.0).
sum_squares([?x|?xs], ?total) :-
  pow(?x, 2.0, ?squared),
  sum_squares(?xs, ?rest),
  add(?squared, ?rest, ?total).

norm(?vector, ?norm) :-
  sum_squares(?vector, ?sumsquares),
  pow(?sumsquares, 0.5, ?norm).

% cosine = dot(A,B) / (norm(A) * norm(B)).
cosine_similarity(?case, ?similarity) :-
  vector(?case, a, ?a),
  vector(?case, b, ?b),
  dot(?a, ?b, ?dot),
  norm(?a, ?norma),
  norm(?b, ?normb),
  mul(?norma, ?normb, ?denominator),
  div(?dot, ?denominator, ?similarity).

dotProduct(?case, ?dot) :-
  vector(?case, a, ?a),
  vector(?case, b, ?b),
  dot(?a, ?b, ?dot).

normA(?case, ?norma) :-
  vector(?case, a, ?a),
  norm(?a, ?norma).

normB(?case, ?normb) :-
  vector(?case, b, ?b),
  norm(?b, ?normb).

cosineSimilarity(?case, ?similarity) :-
  cosine_similarity(?case, ?similarity).
