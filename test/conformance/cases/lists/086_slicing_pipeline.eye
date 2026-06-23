% Reference 9.7: head/rest/last/take/drop/slice are deterministic reusable list operations.
materialize(answer, 2).
data([zero, one, two, three, four]).
answer(head, ?x) :- data(?l), head(?l, ?x).
answer(rest, ?x) :- data(?l), rest(?l, ?x).
answer(last, ?x) :- data(?l), last(?l, ?x).
answer(take_three, ?x) :- data(?l), take(3, ?l, ?x).
answer(drop_three, ?x) :- data(?l), drop(3, ?l, ?x).
answer(slice_middle, ?x) :- data(?l), slice(1, 3, ?l, ?x).
answer(slice_tail_empty, ?x) :- data(?l), slice(5, 0, ?l, ?x).
