% Reference 3.4, 5.1: `?_name` variables are named variables; only exactly `?` is anonymous.
pair(a, a).
pair(a, b).
answer(shared, ?_value) :- pair(?_value, ?_value).
materialize(answer, 2).
