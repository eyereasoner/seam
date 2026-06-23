% Reference 9.1: reusable list selectors and slices have explicit finite boundary behavior.
materialize(answer, 2).
answer(take_zero, ?x) :- take(0, [a, b, c], ?x).
answer(drop_all, ?x) :- drop(3, [a, b, c], ?x).
answer(slice_empty, ?x) :- slice(1, 0, [a, b, c], ?x).
answer(last_single, ?x) :- last([only], ?x).
answer(head_rest, pair(?h, ?r)) :- head([a, b, c], ?h), rest([a, b, c], ?r).
answer(take_too_many_rejected, ok) :- not(take(4, [a, b, c], ?x)).
answer(drop_too_many_rejected, ok) :- not(drop(4, [a, b, c], ?x)).
answer(last_empty_rejected, ok) :- not(last([], ?x)).
