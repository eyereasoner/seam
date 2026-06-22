% Linear logic emulation with explicit consumable resources.
%
% Eyelang predicates are reusable Horn clauses, so this example represents the
% linear part explicitly as a multiset-like state list.  A rule consumes its
% input resources with select/3 and produces a new state.  If a resource is not
% present, the step fails, which models the “use exactly once” discipline of
% linear implication.
%
% The successful plan turns wheat, yeast, and heat into bread.  The rejected
% double-spend check shows that one coin cannot be consumed by two purchases.
materialize(linear_result, 3).
materialize(linear_check, 2).

initial(kitchen, [wheat, yeast, heat]).
initial(wallet, [coin]).

% linear_rule(Name, Inputs, Outputs) is an encoded linear implication:
% Inputs -o Outputs, evaluated against the current resource state.
linear_rule(mill, [wheat], [flour]).
linear_rule(mix, [flour, yeast], [dough]).
linear_rule(bake, [dough, heat], [bread]).
linear_rule(buy_flour, [coin], [flour]).
linear_rule(buy_yeast, [coin], [yeast]).

% consume_all/3 removes each required resource once.  This is the key linear
% operation: a second attempt to use the same token cannot succeed.
consume_all([], ?state, ?state).
consume_all([?need | ?needs], ?state0, ?state2) :-
  select(?need, ?state0, ?state1),
  consume_all(?needs, ?state1, ?state2).

linear_step(?state0, ?rule, ?state2) :-
  linear_rule(?rule, ?inputs, ?outputs),
  consume_all(?inputs, ?state0, ?rest),
  append(?outputs, ?rest, ?state2).

run_linear(0, ?state, [], ?state).
run_linear(?steps, ?state0, [?rule | ?plan], ?state2) :-
  gt(?steps, 0),
  linear_step(?state0, ?rule, ?state1),
  sub(?steps, 1, ?remaining),
  run_linear(?remaining, ?state1, ?plan, ?state2).

linear_result(kitchen, ?plan, ?finalstate) :-
  initial(kitchen, ?state),
  run_linear(3, ?state, ?plan, ?finalstate),
  eq(?finalstate, [bread]).

linear_check(double_spend_rejected, yes) :-
  initial(wallet, ?state),
  not(run_linear(2, ?state, [buy_flour, buy_yeast], ?_finalstate)).
