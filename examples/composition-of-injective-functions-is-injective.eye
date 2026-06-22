% Composition of injective functions is injective, adapted from Eyeling's
% examples/composition-of-injective-functions-is-injective.n3.
%
% The output mirrors the Eyeling golden result shape:
% sameInputByCompositeInjectivity(h, a, b) and the symmetric counterpart.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(sameInputByCompositeInjectivity, 3).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
inX(a).
inX(b).
inY(c).
inY(d).
inZ(e).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
sameTerm(?x, ?x) :- inX(?x).
sameTerm(?x, ?x) :- inY(?x).
sameTerm(?x, ?x) :- inZ(?x).
sameTerm(?y, ?x) :- sameTerm(?x, ?y).

app(f, a, c).
app(f, b, d).
app(g, c, e).
app(g, d, e).

injective(f).
injective(g).
compositeOf(h, g, f).

app(?h, ?x, ?z) :-
  compositeOf(?h, ?g, ?f),
  app(?f, ?x, ?y),
  app(?g, ?y, ?z).

sameTerm(?x, ?y) :-
  injective(?f),
  app(?f, ?x, ?u),
  app(?f, ?y, ?v),
  sameTerm(?u, ?v).

sameInputByCompositeInjectivity(?h, ?x, ?y) :-
  compositeOf(?h, ?g, ?f),
  injective(?g),
  injective(?f),
  app(?h, ?x, ?z),
  app(?h, ?y, ?z),
  sameTerm(?x, ?y),
  neq(?x, ?y).
