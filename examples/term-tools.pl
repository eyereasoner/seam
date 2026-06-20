% Term-tool builtins for inspecting, constructing, rendering, and validating structured terms.
% functor/3, arg/3, and compound_name_arguments/3 expose term shape and arguments.
% term_string/2 renders a term, and forall/2 validates that every edge weight is positive.
materialize(report, 2).

edge(a, b, 3).
edge(b, c, 4).

report(shape, shape(Name, Arity)) :-
  functor(edge(a, b, 3), Name, Arity).

report(second_argument, Node) :-
  arg(2, edge(a, b, 3), Node).

report(parts, parts(Name, Args)) :-
  compound_name_arguments(edge(a, b, 3), Name, Args).

report(rebuilt, Term) :-
  compound_name_arguments(Term, edge, [c, d, 5]).

report(rendered, Text) :-
  term_string(edge(a, [b, c]), Text).

report(all_weights_positive, yes) :-
  forall(edge(_From, _To, Weight), gt(Weight, 0)).
