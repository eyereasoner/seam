% Reference 9.2: integer arithmetic keeps exact BigInt paths where possible.
materialize(answer, 2).
answer(add_big, ?x) :- add(9007199254740993, 7, ?x).
answer(sub_big, ?x) :- sub(9007199254741000, 7, ?x).
answer(mul_big, ?x) :- mul(123456789, 987654321, ?x).
answer(pow_big, ?x) :- pow(2, 63, ?x).
answer(div_big, ?x) :- div(9223372036854775808, 2, ?x).
answer(mod_big, ?x) :- mod(9223372036854775809, 10, ?x).
