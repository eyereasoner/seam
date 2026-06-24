% A tiny partial evaluator for expression terms.
%
% Real partial evaluation can specialize interpreters, control unfolding, avoid
% code explosion, and even approach self-application.  This bounded Eyelang
% version specializes a miniature expression language with known static inputs:
% constants are folded, known variables are substituted, and dynamic variables
% remain as residual code.

materialize(partialEvalAnswer, 2).

table(pe, 3).

% Expression language: const/1, bool/1, var/1, add/2, mul/2, and if/3.
% Static environments are lists of bind(Name, ResidualValue) terms.
program(poly_y,
  add(mul(var(x), var(y)), add(var(x), const(3))),
  [bind(x, const(10))]).
program(static_branch,
  if(bool(true), add(var(x), const(1)), mul(var(y), const(999))),
  [bind(x, const(10))]).
program(dynamic_branch,
  if(var(flag), add(var(x), const(1)), mul(var(y), const(2))),
  [bind(x, const(10))]).

lookup(?name, [bind(?name, ?value) | ?], ?value).
lookup(?name, [bind(?, ?) | ?rest], ?value) :- lookup(?name, ?rest, ?value).

known_var(?env, ?name, ?value) :- lookup(?name, ?env, ?value).
unknown_var(?env, ?name) :- not(known_var(?env, ?name, ?)).

pe(?, const(?n), const(?n)).
pe(?, bool(?b), bool(?b)).
pe(?env, var(?name), ?value) :- known_var(?env, ?name, ?value).
pe(?env, var(?name), var(?name)) :- unknown_var(?env, ?name).

% Constant folding for arithmetic when both residual operands became constants.
pe(?env, add(?left, ?right), const(?sum)) :-
  pe(?env, ?left, const(?a)),
  pe(?env, ?right, const(?b)),
  add(?a, ?b, ?sum).
pe(?env, mul(?left, ?right), const(?product)) :-
  pe(?env, ?left, const(?a)),
  pe(?env, ?right, const(?b)),
  mul(?a, ?b, ?product).

% Residual arithmetic when at least one operand remains dynamic.
pe(?env, add(?left, ?right), add(?left_residual, ?right_residual)) :-
  pe(?env, ?left, ?left_residual),
  pe(?env, ?right, ?right_residual),
  not((eq(?left_residual, const(?a)), eq(?right_residual, const(?b)))).
pe(?env, mul(?left, ?right), mul(?left_residual, ?right_residual)) :-
  pe(?env, ?left, ?left_residual),
  pe(?env, ?right, ?right_residual),
  not((eq(?left_residual, const(?a)), eq(?right_residual, const(?b)))).

% Static conditionals choose a branch; dynamic conditionals keep both residual
% branches after specializing their contents.
pe(?env, if(?cond, ?then, ?else), ?residual) :-
  pe(?env, ?cond, bool(true)),
  pe(?env, ?then, ?residual).
pe(?env, if(?cond, ?then, ?else), ?residual) :-
  pe(?env, ?cond, bool(false)),
  pe(?env, ?else, ?residual).
pe(?env, if(?cond, ?then, ?else), if(?cond_residual, ?then_residual, ?else_residual)) :-
  pe(?env, ?cond, ?cond_residual),
  not(eq(?cond_residual, bool(true))),
  not(eq(?cond_residual, bool(false))),
  pe(?env, ?then, ?then_residual),
  pe(?env, ?else, ?else_residual).

residual_program(?name, ?residual) :- program(?name, ?expr, ?env), pe(?env, ?expr, ?residual).

partialEvalAnswer(residual(?name), ?residual) :- residual_program(?name, ?residual).
partialEvalAnswer(note, "static inputs are folded while dynamic variables remain as residual code") :- residual_program(poly_y, ?).
