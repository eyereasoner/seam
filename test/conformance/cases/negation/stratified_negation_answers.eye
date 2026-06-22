% Stratified negation is portable and produces ordinary answers.
materialize(open, 1).
place(a).
place(b).
closed(b).
open(?x) :- place(?x), not(closed(?x)).
