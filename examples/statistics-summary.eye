% Population statistics for a small numeric sample.
%
% The sample is the textbook data set [2,4,4,4,5,5,7,9], whose population
% mean is 5, variance is 4, and standard deviation is 2.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(count, 2).
materialize(mean, 2).
materialize(populationVariance, 2).
materialize(populationStddev, 2).

% The sample is one list fact, which lets recursive list folds demonstrate
% aggregation without introducing a separate row relation.
sample(scores, [2.0, 4.0, 4.0, 4.0, 5.0, 5.0, 7.0, 9.0]).

sum([], 0.0).
% sum/2 and squared_error_sum/3 are recursive folds; the public relations then
% derive count, mean, population variance, and standard deviation.
sum([?x|?xs], ?total) :-
  sum(?xs, ?rest),
  add(?x, ?rest, ?total).

mean(?name, ?mean) :-
  sample(?name, ?values),
  sum(?values, ?total),
  length(?values, ?count),
  div(?total, ?count, ?mean).

squared_error_sum([], ?_mean, 0.0).
squared_error_sum([?x|?xs], ?mean, ?total) :-
  sub(?x, ?mean, ?delta),
  pow(?delta, 2.0, ?squared),
  squared_error_sum(?xs, ?mean, ?rest),
  add(?squared, ?rest, ?total).

population_variance(?name, ?variance) :-
  sample(?name, ?values),
  mean(?name, ?mean),
  squared_error_sum(?values, ?mean, ?sumsquarederrors),
  length(?values, ?count),
  div(?sumsquarederrors, ?count, ?variance).

population_stddev(?name, ?stddev) :-
  population_variance(?name, ?variance),
  pow(?variance, 0.5, ?stddev).

count(?name, ?count) :-
  sample(?name, ?values),
  length(?values, ?count).


populationVariance(?name, ?variance) :-
  population_variance(?name, ?variance).

populationStddev(?name, ?stddev) :-
  population_stddev(?name, ?stddev).
