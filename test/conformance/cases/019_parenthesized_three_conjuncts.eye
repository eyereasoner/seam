% Reference 5.5, 7: parenthesized comma terms with more than two members are conjunctions as goals.
p(a).
q(a).
r(a).
ok(?x) :- (p(?x), q(?x), r(?x)).
answer(ok, ?x) :- ok(?x).
materialize(answer, 2).
