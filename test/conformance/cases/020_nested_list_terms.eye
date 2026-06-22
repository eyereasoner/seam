% Reference 5.3, 5.4: lists may contain structured terms that unify positionally.
node([pair(a, b), pair(c, d)]).
answer(first_key, ?x) :- node([pair(?x, ?_), pair(c, d)]).
answer(second_key, ?x) :- node([pair(a, b), pair(?x, d)]).
materialize(answer, 2).
