% Reference 9.1: forall/2 succeeds for every generated binding, including the empty generator case.
materialize(answer, 2).
small(1).
small(2).
large(3).
answer(all_small, ok) :- forall(small(?x), lt(?x, 3)).
answer(empty_generator, ok) :- forall(missing(?x), lt(?x, 0)).
answer(not_all_large, ok) :- not(forall(large(?x), lt(?x, 3))).
answer(bound_outer_environment, ok) :- small(?x), eq(?x, 1), forall(small(?y), le(?x, ?y)).
answer(checker_can_use_generator_binding, ok) :- forall(small(?x), member(?x, [1, 2, 3])).
