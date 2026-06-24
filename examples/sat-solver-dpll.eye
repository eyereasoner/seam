% DPLL-style SAT solving for a small CNF formula.
%
% The example keeps the solver itself in Eyelang.  It recursively assigns
% variables in a fixed order, prunes a branch as soon as any clause is already
% impossible, and accepts a complete assignment when every clause is satisfied.
% aggregate_min/5 is then used only to choose one canonical satisfying model.

materialize(satModel, 1).
materialize(satValue, 2).
materialize(satClauseStatus, 2).
materialize(satConclusion, 2).

% CNF formula:
%   (a or b)
%   (not a or c)
%   (not b or c)
%   (not c or d)
%   (c or not d)
variable_order([a, b, c, d]).
clause(c1, [pos(a), pos(b)]).
clause(c2, [neg(a), pos(c)]).
clause(c3, [neg(b), pos(c)]).
clause(c4, [neg(c), pos(d)]).
clause(c5, [pos(c), neg(d)]).

bool(false).
bool(true).
bit(false, 0).
bit(true, 1).

% Look up a variable inside a partial or complete assignment represented as a
% list of bind(Name, Bool) terms.
lookup_bool(?name, [bind(?name, ?value) | ?], ?value).
lookup_bool(?name, [bind(?, ?) | ?rest], ?value) :- lookup_bool(?name, ?rest, ?value).

literal_true(pos(?var), ?assignment) :- lookup_bool(?var, ?assignment, true).
literal_true(neg(?var), ?assignment) :- lookup_bool(?var, ?assignment, false).
literal_false(pos(?var), ?assignment) :- lookup_bool(?var, ?assignment, false).
literal_false(neg(?var), ?assignment) :- lookup_bool(?var, ?assignment, true).

clause_satisfied(?assignment, ?clause_name) :-
  clause(?clause_name, ?literals),
  member(?literal, ?literals),
  literal_true(?literal, ?assignment).

% A partial branch is impossible when every literal in a clause is already false.
% Unassigned literals keep the branch alive, just as in DPLL.
clause_impossible(?assignment, ?clause_name) :-
  clause(?clause_name, ?literals),
  forall(member(?literal, ?literals), literal_false(?literal, ?assignment)).
partial_consistent(?assignment) :- not((clause(?name, ?), clause_impossible(?assignment, ?name))).
complete_model(?assignment) :- forall(clause(?name, ?), clause_satisfied(?assignment, ?name)).

% Recursive DPLL search: choose a truth value, prune if inconsistent, then
% continue with the remaining variables.
dpll([], ?assignment, ?assignment) :- complete_model(?assignment).
dpll([?var | ?rest], ?partial, ?model) :-
  bool(?value),
  partial_consistent([bind(?var, ?value) | ?partial]),
  dpll(?rest, [bind(?var, ?value) | ?partial], ?model).

satisfying_model(?model) :- variable_order(?vars), dpll(?vars, [], ?model).

% Rank models so the materialized output shows one deterministic answer.  The
% model list is in reverse decision order because each decision is pushed onto
% the front during recursion.
model_rank(?model, ?rank) :-
  lookup_bool(a, ?model, ?a), bit(?a, ?abit),
  lookup_bool(b, ?model, ?b), bit(?b, ?bbit),
  lookup_bool(c, ?model, ?c), bit(?c, ?cbit),
  lookup_bool(d, ?model, ?d), bit(?d, ?dbit),
  mul(?abit, 8, ?arank),
  mul(?bbit, 4, ?brank),
  mul(?cbit, 2, ?crank),
  add(?arank, ?brank, ?ab),
  add(?crank, ?dbit, ?cd),
  add(?ab, ?cd, ?rank).

best_model(?model, ?rank) :-
  aggregate_min(?candidate_rank, ?candidate_model,
    (satisfying_model(?candidate_model), model_rank(?candidate_model, ?candidate_rank)),
    ?rank, ?model).

satModel(?model) :- best_model(?model, ?).
satValue(?var, ?value) :- best_model(?model, ?), lookup_bool(?var, ?model, ?value).
satClauseStatus(?clause, satisfied) :- best_model(?model, ?), clause_satisfied(?model, ?clause).
satConclusion(case, "DPLL finds a satisfying assignment after pruning clauses that become impossible") :-
  best_model(?, ?).
