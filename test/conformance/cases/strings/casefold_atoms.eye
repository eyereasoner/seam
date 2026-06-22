materialize(answer, 2).
answer(lower, ?x) :- lowercase("HelloWorld", ?x).
answer(upper, ?x) :- uppercase(helloWorld, ?x).
