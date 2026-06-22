% Reference 5.4: improper list surface syntax unifies with head-tail structure.
cell([head | tail], head, tail).
answer(list, ?l) :- cell(?l, head, tail).
answer(head, ?h) :- cell([?h | tail], ?h, tail).
answer(tail, ?t) :- cell([head | ?t], head, ?t).
materialize(answer, 2).
