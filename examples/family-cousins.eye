% Memoize scoped family projection and recursive labels; cousin derivation asks
% for the same generation and branch facts many times.
% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(generation, 2).
materialize(branch, 2).
materialize(cousin, 2).

% The family tree is scoped inside family_graph/2.  family_statement/3 projects
% only the parent and seedBranch facts that the cousin rules need.
table(family_statement, 3).
table(generation, 2).
table(branch, 2).

% Family-cousins derivation adapted from Eyeling family-cousins.n3.
% Generation numbers are derived from parent links; branch labels distinguish
% descendants of Bob from descendants of Carol.
% The family tree and seed branch labels are quoted as a small formula term, so
% the rules derive from scoped family data rather than global relationship facts.

family_graph(familyGraph, (
  parent(adam, bob),
  parent(adam, carol),
  parent(bob, dave),
  parent(bob, eve),
  parent(carol, frank),
  parent(carol, grace),
  parent(dave, heidi),
  parent(eve, ivan),
  parent(frank, judy),
  seedBranch(dave, b),
  seedBranch(eve, b),
  seedBranch(frank, c),
  seedBranch(grace, c)
)).

% generation/2 walks parent links from Adam, branch/2 propagates seed labels,
% and cousin/2 combines equal generation with different branches.
family_statement(?s, ?p, ?o) :- family_graph(familyGraph, ?context), holds(?context, ?p, [?s, ?o]).

parent(?parent, ?child) :- family_statement(?parent, parent, ?child).
branch(?person, ?branch) :- family_statement(?person, seedBranch, ?branch).

different(b, c).
different(c, b).

generation(adam, 0).
generation(?child, ?next) :-
  parent(?parent, ?child),
  generation(?parent, ?gen),
  add(?gen, 1, ?next).

branch(?child, ?branch) :-
  parent(?parent, ?child),
  branch(?parent, ?branch).

derived_branch(?child, ?branch) :-
  parent(?parent, ?child),
  branch(?parent, ?branch).

cousin(?x, ?y) :-
  generation(?x, ?gen),
  generation(?y, ?gen),
  branch(?x, ?bx),
  branch(?y, ?by),
  different(?bx, ?by).

branch(?person, ?branch) :- derived_branch(?person, ?branch).
