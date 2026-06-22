% A tiny tabled chart parser for a context-free grammar.
%
% span(Sentence, Category, Start, End) is the dynamic-programming chart item:
% Category covers a half-open token interval.  Memoizing span/4 turns recursive
% grammar recognition into chart parsing, so ambiguous phrases share subparses.
materialize(chart_parser_answer, 2).

table(span, 4).

% Two sample sentences share the same tiny grammar but have different parse counts.

sentence(command, 5).
sentence(ambiguous_pp, 8).

word(command, 0, the).
word(command, 1, robot).
word(command, 2, moves).
word(command, 3, the).
word(command, 4, box).

word(ambiguous_pp, 0, the).
word(ambiguous_pp, 1, robot).
word(ambiguous_pp, 2, sees).
word(ambiguous_pp, 3, the).
word(ambiguous_pp, 4, box).
word(ambiguous_pp, 5, with).
word(ambiguous_pp, 6, the).
word(ambiguous_pp, 7, telescope).

terminal(det, the).
terminal(noun, robot).
terminal(noun, box).
terminal(noun, telescope).
terminal(verb, moves).
terminal(verb, sees).
terminal(prep, with).

rule(s, np, vp).
rule(np, det, noun).
rule(np, np, pp).
rule(vp, verb, np).
rule(vp, vp, pp).
rule(pp, prep, np).

% Lexical chart items come directly from words and terminal categories.
span(?sentence, ?category, ?start, ?end) :-
  word(?sentence, ?start, ?token),
  terminal(?category, ?token),
  add(?start, 1, ?end).
% Nonterminal chart items split the interval at a Middle point.
span(?sentence, ?category, ?start, ?end) :-
  rule(?category, ?left, ?right),
  span(?sentence, ?left, ?start, ?middle),
  span(?sentence, ?right, ?middle, ?end).

chart_parser_answer(parsed, ?sentence) :-
  sentence(?sentence, ?length),
  span(?sentence, s, 0, ?length).
chart_parser_answer(parse_count, count(?sentence, ?count)) :-
  sentence(?sentence, ?length),
  countall(span(?sentence, s, 0, ?length), ?count).
chart_parser_answer(noun_phrase_count, count(?sentence, ?count)) :-
  sentence(?sentence, ?length),
  countall(span(?sentence, np, ?_start, ?_end), ?count),
  gt(?length, 0).
