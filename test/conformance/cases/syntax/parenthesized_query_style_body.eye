% Parentheses may group a body conjunction without changing meaning.
materialize(answer, 1).
a(ok).
b(ok).
answer(?x) :- (a(?x), b(?x)).
