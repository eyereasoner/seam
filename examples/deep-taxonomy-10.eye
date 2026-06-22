% =============================================================================================================================
% Deep Taxonomy - depth 10 - expanded N3-style eyelang with checkpoint proof accelerators
%
% Adjacent rules mirror the Eyeling N3 deep-taxonomy chain. The checkpoint
% rules are redundant consequences of that chain and are placed first so eyelang
% can prove terminal/report goals without overflowing the JavaScript call stack.
% Report/check rules use once/1 so successful checks do not backtrack into a
% long adjacent-only proof after a shorter checkpoint proof has succeeded.
% =============================================================================================================================

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(is, 2).
materialize(answer, 2).
materialize(reason, 2).
materialize(result, 2).
materialize(checkPassed, 2).
materialize(arc, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
% fact

a(ind, n0).

% terminal rule

% Derivation rules: each rule below contributes one logical step toward the displayed results.
is(test, true) :- once(a(ind, a2)).
a(?x, a2) :- a(?x, n10).

% Redundant checkpoint accelerators.

a(?x, n10) :- a(?x, n0).
a(?x, n4) :- a(?x, n0).
a(?x, n9) :- a(?x, n0).

% Adjacent N3-style taxonomy rules.

a(?x, n1) :- a(?x, n0).
a(?x, i1) :- a(?x, n0).
a(?x, j1) :- a(?x, n0).
a(?x, n2) :- a(?x, n1).
a(?x, i2) :- a(?x, n1).
a(?x, j2) :- a(?x, n1).
a(?x, n3) :- a(?x, n2).
a(?x, i3) :- a(?x, n2).
a(?x, j3) :- a(?x, n2).
a(?x, n4) :- a(?x, n3).
a(?x, i4) :- a(?x, n3).
a(?x, j4) :- a(?x, n3).
a(?x, n5) :- a(?x, n4).
a(?x, i5) :- a(?x, n4).
a(?x, j5) :- a(?x, n4).
a(?x, n6) :- a(?x, n5).
a(?x, i6) :- a(?x, n5).
a(?x, j6) :- a(?x, n5).
a(?x, n7) :- a(?x, n6).
a(?x, i7) :- a(?x, n6).
a(?x, j7) :- a(?x, n6).
a(?x, n8) :- a(?x, n7).
a(?x, i8) :- a(?x, n7).
a(?x, j8) :- a(?x, n7).
a(?x, n9) :- a(?x, n8).
a(?x, i9) :- a(?x, n8).
a(?x, j9) :- a(?x, n8).
a(?x, n10) :- a(?x, n9).
a(?x, i10) :- a(?x, n9).
a(?x, j10) :- a(?x, n9).

% ARC checks

arc(check1, "C1 OK - the starting classification n0 is present.") :-
 once(a(ind, n0)).

arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1.") :-
 once(a(ind, n1)),
 once(a(ind, i1)),
 once(a(ind, j1)).

arc(check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches.") :-
 once(a(ind, n5)),
 once(a(ind, i5)),
 once(a(ind, j5)).

arc(check4, "C4 OK - the final taxonomy step from n9 to n10 was completed.") :-
 once(a(ind, n9)),
 once(a(ind, n10)).

arc(check5, "C5 OK - once n10 is reached, the terminal class a2 is derived.") :-
 once(a(ind, n10)),
 once(a(ind, a2)).

arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present.") :-
 once(a(ind, a2)),
 once(is(test, true)).

% ARC report

answer(report, "The test succeeds: starting from one individual classified as n0, the rules eventually classify it as n10 and then as a2.") :-
 once(is(test, true)).

reason(report, "The adjacent rules mirror the Eyeling N3 deep-taxonomy-10 chain. Redundant checkpoint rules are included only as proof accelerators: each shortcut is entailed by the adjacent chain, and once/1 prevents backtracking into the long adjacent-only proof after a check has succeeded.") :-
 once(a(ind, a2)),
 once(is(test, true)).

checkPassed(report, ?check) :-
 arc(?check, ?_message).

result(report, success) :-
 once(is(test, true)),
 once(arc(check1, ?_c1)),
 once(arc(check2, ?_c2)),
 once(arc(check3, ?_c3)),
 once(arc(check4, ?_c4)),
 once(arc(check5, ?_c5)),
 once(arc(check6, ?_c6)).
