% Reference 9.6: split/join/trim compose for simple data-cleaning workflows.
materialize(answer, 2).
raw("  alpha,beta,gamma  ").
answer(parts, ?x) :- raw(?r), trim(?r, ?t), split(?t, ",", ?x).
answer(pipe, ?x) :- raw(?r), trim(?r, ?t), split(?t, ",", ?parts), join(?parts, "|", ?x).
answer(first_upper, ?x) :- raw(?r), trim(?r, ?t), split(?t, ",", ?parts), head(?parts, ?h), uppercase(?h, ?x).
answer(last_lower, ?x) :- raw(?r), trim(?r, ?t), split(?t, ",", ?parts), last(?parts, ?l), lowercase(?l, ?x).
