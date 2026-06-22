% Diamond property, adapted from Eyelet's input/diamond-property.eye.
%
% A relation has the diamond property when two outgoing steps from the same
% source can be joined again.  This compact eyelang version keeps the same
% diamond idea and also checks that it is preserved by reflexive closure.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(holdsFor, 2).
materialize(commonSuccessor, 2).
materialize(preservedUnderReflexiveClosure, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
node(a).
node(b).
node(c).
node(d).

r(a, b).
r(a, c).
r(b, d).
r(c, d).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
re(?x, ?x) :- node(?x).
re(?x, ?y) :- r(?x, ?y).

diamond(?rel, ?a, ?b, ?c, ?d) :-
  step(?rel, ?a, ?b),
  step(?rel, ?a, ?c),
  step(?rel, ?b, ?d),
  step(?rel, ?c, ?d).

step(r, ?x, ?y) :- r(?x, ?y).
step(re, ?x, ?y) :- re(?x, ?y).

holdsFor(diamondProperty, ?rel) :- diamond(?rel, a, b, c, d).
commonSuccessor(diamondProperty, ?d) :- diamond(r, a, b, c, ?d).
preservedUnderReflexiveClosure(diamondProperty, true) :- diamond(re, a, b, c, d).
