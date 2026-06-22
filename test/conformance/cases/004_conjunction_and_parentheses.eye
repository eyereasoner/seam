% Reference 5.5, 7: parenthesized comma terms are conjunctions in goal position.
p(a).
q(a).
ok(?x, yes) :- (p(?x), q(?x)).
materialize(ok, 2).
