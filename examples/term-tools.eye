% Term-tool builtins for inspecting, constructing, rendering, and validating
% structured terms.
%
% Each report/2 answer demonstrates one meta-programming operation over ordinary
% Eyelang terms: functor/3 and arg/3 inspect shape, compound_name_arguments/3 can
% decompose or rebuild a compound, term_string/2 renders a term, and forall/2
% validates all edge weights.
%
% This is a good reference example when writing rules that need to treat terms as
% data rather than only as predicate calls.
materialize(report, 2).

edge(a, b, 3).
edge(b, c, 4).

report(shape, shape(?name, ?arity)) :-
  functor(edge(a, b, 3), ?name, ?arity).

report(second_argument, ?node) :-
  arg(2, edge(a, b, 3), ?node).

report(parts, parts(?name, ?args)) :-
  compound_name_arguments(edge(a, b, 3), ?name, ?args).

report(rebuilt, ?term) :-
  compound_name_arguments(?term, edge, [c, d, 5]).

report(rendered, ?text) :-
  term_string(edge(a, [b, c]), ?text).

report(all_weights_positive, yes) :-
  forall(edge(?_from, ?_to, ?weight), gt(?weight, 0)).
