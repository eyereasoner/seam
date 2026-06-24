% Hindley-Milner-style type inference for a tiny lambda language.
%
% The example is intentionally small and deterministic.  Lambda binders carry
% explicit type variables or annotations, and ordinary logic unification solves
% the constraints created by application, arithmetic, conditionals, and pairs.
% The symbolic names t0, t1, and t2 stand for schematic type variables in the
% displayed answers; concrete examples such as apply_id annotate the argument as
% int so the application can be checked.
materialize(type_answer, 2).
materialize(type_reason, 2).

table(type_expr, 3).

% Tiny expression language: int_lit/1, bool_lit/1, var/1, lam/3, app/2,
% add/2, if/3, pair/2, fst/1, and snd/1.
program(id, lam(x, t0, var(x))).
program(const, lam(x, t0, lam(y, t1, var(x)))).
program(apply_id, app(lam(x, int, var(x)), int_lit(42))).
program(compose,
  lam(f, fun(t1, t2),
    lam(g, fun(t0, t1),
      lam(x, t0,
        app(var(f), app(var(g), var(x))))))).
program(branch,
  if(bool_lit(true), add(int_lit(20), int_lit(22)), int_lit(0))).
program(first_of_pair, fst(pair(bool_lit(true), int_lit(7)))).

lookup(?name, [[?name, ?type] | ?], ?type).
lookup(?name, [[?, ?] | ?rest], ?type) :- lookup(?name, ?rest, ?type).

type_expr(?, int_lit(?), int).
type_expr(?, bool_lit(?), bool).
type_expr(?env, var(?name), ?type) :- lookup(?name, ?env, ?type).
type_expr(?env, lam(?name, ?arg_type, ?body), fun(?arg_type, ?body_type)) :-
  type_expr([[?name, ?arg_type] | ?env], ?body, ?body_type).
type_expr(?env, app(?fn, ?arg), ?result_type) :-
  type_expr(?env, ?fn, fun(?arg_type, ?result_type)),
  type_expr(?env, ?arg, ?arg_type).
type_expr(?env, add(?left, ?right), int) :-
  type_expr(?env, ?left, int),
  type_expr(?env, ?right, int).
type_expr(?env, if(?cond, ?then, ?else), ?type) :-
  type_expr(?env, ?cond, bool),
  type_expr(?env, ?then, ?type),
  type_expr(?env, ?else, ?type).
type_expr(?env, pair(?left, ?right), pair(?left_type, ?right_type)) :-
  type_expr(?env, ?left, ?left_type),
  type_expr(?env, ?right, ?right_type).
type_expr(?env, fst(?pair), ?left_type) :-
  type_expr(?env, ?pair, pair(?left_type, ?)).
type_expr(?env, snd(?pair), ?right_type) :-
  type_expr(?env, ?pair, pair(?, ?right_type)).

type_answer(?name, ?type) :- program(?name, ?expr), type_expr([], ?expr, ?type).
type_reason(compose, "application unifies f with t1 -> t2 and g with t0 -> t1") :-
  type_answer(compose, ?).
type_reason(apply_id, "the identity function's parameter type is unified with int") :-
  type_answer(apply_id, int).
