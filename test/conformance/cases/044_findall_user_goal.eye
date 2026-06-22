% Reference 9.8: findall/3 collects templates for every solution of a user goal.
p(b).
p(a).
p(b).
answer(bag, ?x) :- findall(?p, p(?p), ?x).
materialize(answer, 2).
