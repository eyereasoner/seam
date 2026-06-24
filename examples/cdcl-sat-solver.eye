% A tiny CDCL-style SAT trace with one learned clause.
%
% Industrial CDCL solvers use watched literals, mutable trails, non-chronological
% backjumping, clause databases, restarts, and activity heuristics.  Eyelang has
% no mutable state or destructive trail updates, so this example models one small
% conflict-analysis episode as relations over immutable terms.
%
% Formula:
%   c1: not(a) or c
%   c2: not(c)
%   c3: a or b
%
% Decision a=true forces c=true by c1, which conflicts with c2.  Resolving the
% reason c1 with the conflict c2 learns not(a).  After backjumping, learned
% not(a) forces a=false, c2 gives c=false, and c3 forces b=true.

materialize(cdclAnswer, 2).

clause(c1, [neg(a), pos(c)]).
clause(c2, [neg(c)]).
clause(c3, [pos(a), pos(b)]).

% Initial trail before conflict analysis.
initial_value(a, true, decision(level1)).
initial_value(c, true, implied_by(c1)).

% The current trail makes a literal true or false.
lit_true(pos(?var), ?value_rel) :- call_value(?value_rel, ?var, true, ?).
lit_true(neg(?var), ?value_rel) :- call_value(?value_rel, ?var, false, ?).
lit_false(pos(?var), ?value_rel) :- call_value(?value_rel, ?var, false, ?).
lit_false(neg(?var), ?value_rel) :- call_value(?value_rel, ?var, true, ?).

% Eyelang cannot pass predicates as first-class values, so this small dispatcher
% lets the same literal helpers inspect either the initial or final trail.
call_value(initial, ?var, ?value, ?reason) :- initial_value(?var, ?value, ?reason).
call_value(final, ?var, ?value, ?reason) :- final_value(?var, ?value, ?reason).

% A clause is conflicting when all of its literals are false under a trail.
conflict(?trail, ?clause) :-
  clause(?clause, ?literals),
  forall(member(?literal, ?literals), lit_false(?literal, ?trail)).

% The learned clause for this tiny implication graph is obtained by resolving
% the conflict clause not(c) with c's reason not(a) or c, yielding not(a).
learned_clause(l1, [neg(a)]).
learned_from(l1, resolve(c2, c1, pivot(c))).

% After backjumping, the learned unit clause fixes a=false.  Then the original
% clauses imply c=false and b=true.
final_value(a, false, learned(l1)).
final_value(c, false, unit(c2)).
final_value(b, true, unit(c3)).

model_satisfies_clause(?trail, ?clause) :-
  clause(?clause, ?literals),
  member(?literal, ?literals),
  lit_true(?literal, ?trail).

final_model_ok(ok) :- forall(clause(?name, ?), model_satisfies_clause(final, ?name)).

cdclAnswer(conflict_clause, ?clause) :- conflict(initial, ?clause).
cdclAnswer(learned_clause, ?literals) :- learned_clause(l1, ?literals).
cdclAnswer(learned_from, ?reason) :- learned_from(l1, ?reason).
cdclAnswer(final_value(?var), ?value) :- final_model_ok(ok), final_value(?var, ?value, ?).
cdclAnswer(note, "one learned clause makes the final model satisfy all original clauses") :- final_model_ok(ok).
