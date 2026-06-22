% Group inverse uniqueness, adapted from Eyeling's examples/group-inverse-uniqueness.n3.
%
% The output mirrors the Eyeling golden result shape:
% sameInverse(x, i, j) and sameInverse(x, j, i).

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(sameInverse, 3).

% The group table is deliberately tiny: e is the identity, and i and j are
% two names that both behave as the inverse of x.
element(e).
element(x).
element(i).
element(j).

% leftInverse/2 and rightInverse/2 are proved from op/3.  sameInverse/3
% then derives uniqueness by combining both inverse directions with sameTerm/2.
op(e, ?x, ?x) :- element(?x).
op(?x, e, ?x) :- element(?x).
op(i, x, e).
op(x, j, e).
op(j, x, e).
op(x, i, e).

sameTerm(?x, ?x) :- element(?x).
sameTerm(i, j).
sameTerm(j, i).

leftInverse(?a, ?b) :- op(?b, ?a, e).
rightInverse(?a, ?b) :- op(?a, ?b, e).

sameInverse(?a, ?b, ?c) :-
  leftInverse(?a, ?b),
  rightInverse(?a, ?c),
  sameTerm(?b, ?c),
  neq(?b, ?c).
