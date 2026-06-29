% Declarations remain ordinary facts unless materialized output excludes them.
materialize(answer, 2).
table(path, 2).
answer(Name, Arity) :- table(Name, Arity).
