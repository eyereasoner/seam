% Reference 9.5: smallest_divisor_from/3 finds the first divisor at or above the start.
answer(divisor, ?d) :- smallest_divisor_from(21, 2, ?d).
materialize(answer, 2).
