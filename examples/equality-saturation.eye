% Bounded equality saturation over tiny arithmetic expression terms.
%
% Real equality-saturation engines use mutable e-graphs, union-find classes,
% congruence closure, rewrite scheduling, and cost-based extraction.  Eyelang has
% none of those primitives, so this example simulates the idea relationally: it
% enumerates expressions reachable within a small rewrite-fuel bound, scores the
% generated terms, and extracts the cheapest equivalent expression.
%
% The point is not to be fast.  The point is to show the declarative shape of an
% e-graph optimizer in a language that was not designed for it.

materialize(egraphAnswer, 2).

table(equivalent_at_depth, 3).
table(expr_cost, 2).

% Start expression:
%   ((x + 0) * 1) + 2 * (1 + 2)
% The best bounded rewrite result should be x + 6.
expr(start, add(mul(add(x, 0), 1), mul(2, add(1, 2)))).
fuel(6).

% Directed rewrite rules.  A true e-graph would keep equalities in equivalence
% classes.  This bounded version uses oriented rewrites so search terminates.
rewrite(add(?x, 0), ?x).
rewrite(add(0, ?x), ?x).
rewrite(mul(?x, 1), ?x).
rewrite(mul(1, ?x), ?x).
rewrite(mul(?x, 0), 0).
rewrite(mul(0, ?x), 0).

% Constant folding and one distributivity rule make the search space less toyish.
rewrite(add(?a, ?b), ?c) :- add(?a, ?b, ?c).
rewrite(mul(?a, ?b), ?c) :- mul(?a, ?b, ?c).
rewrite(mul(?x, add(?y, ?z)), add(mul(?x, ?y), mul(?x, ?z))).

% Apply a rewrite at the root or inside one subterm.
rewrite_anywhere(?in, ?out) :- rewrite(?in, ?out).
rewrite_anywhere(add(?a, ?b), add(?new_a, ?b)) :- rewrite_anywhere(?a, ?new_a).
rewrite_anywhere(add(?a, ?b), add(?a, ?new_b)) :- rewrite_anywhere(?b, ?new_b).
rewrite_anywhere(mul(?a, ?b), mul(?new_a, ?b)) :- rewrite_anywhere(?a, ?new_a).
rewrite_anywhere(mul(?a, ?b), mul(?a, ?new_b)) :- rewrite_anywhere(?b, ?new_b).

% Fuel-bounded closure.  Every depth represents exactly that many rewrite steps;
% candidate_expression/1 looks across all depths from zero to the fuel limit.
equivalent_at_depth(0, ?expr, ?expr).
equivalent_at_depth(?depth, ?expr, ?out) :-
  gt(?depth, 0),
  sub(?depth, 1, ?previous_depth),
  equivalent_at_depth(?previous_depth, ?expr, ?mid),
  rewrite_anywhere(?mid, ?out).

candidate_expression(?candidate) :-
  expr(start, ?expr),
  fuel(?fuel),
  between(0, ?fuel, ?depth),
  equivalent_at_depth(?depth, ?expr, ?candidate).

% A tiny cost model for extraction.  Leaves cost 1; compound nodes cost 1 plus
% their children.  The numeric range is deliberately bounded for the generated
% constants in this example.
expr_cost(x, 1).
expr_cost(?n, 1) :- between(0, 20, ?n).
expr_cost(add(?a, ?b), ?cost) :-
  expr_cost(?a, ?a_cost),
  expr_cost(?b, ?b_cost),
  add(?a_cost, ?b_cost, ?children),
  add(?children, 1, ?cost).
expr_cost(mul(?a, ?b), ?cost) :-
  expr_cost(?a, ?a_cost),
  expr_cost(?b, ?b_cost),
  add(?a_cost, ?b_cost, ?children),
  add(?children, 1, ?cost).

best_expression(?expr, ?cost) :-
  aggregate_min([?candidate_cost, ?candidate], ?candidate,
    (candidate_expression(?candidate), expr_cost(?candidate, ?candidate_cost)),
    [?cost, ?expr], ?expr).

egraphAnswer(start, ?expr) :- expr(start, ?expr).
egraphAnswer(best, ?expr) :- best_expression(?expr, ?).
egraphAnswer(cost, ?cost) :- best_expression(?, ?cost).
egraphAnswer(candidate_count, ?count) :- countall(candidate_expression(?), ?count).
egraphAnswer(note, "bounded equality saturation extracts the cheapest term without a real e-graph") :- best_expression(?, ?).
