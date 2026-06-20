% A tiny memoized chart parser for a context-free grammar.
% span/4 is the dynamic-programming chart relation: sentence, category,
% start index, and end index.
materialize(chart_parser_answer, 2).

memoize(span, 4).

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

span(Sentence, Category, Start, End) :-
  word(Sentence, Start, Token),
  terminal(Category, Token),
  add(Start, 1, End).
span(Sentence, Category, Start, End) :-
  rule(Category, Left, Right),
  span(Sentence, Left, Start, Middle),
  span(Sentence, Right, Middle, End).

chart_parser_answer(parsed, Sentence) :-
  sentence(Sentence, Length),
  span(Sentence, s, 0, Length).
chart_parser_answer(parse_count, count(Sentence, Count)) :-
  sentence(Sentence, Length),
  countall(span(Sentence, s, 0, Length), Count).
chart_parser_answer(noun_phrase_count, count(Sentence, Count)) :-
  sentence(Sentence, Length),
  countall(span(Sentence, np, _Start, _End), Count),
  gt(Length, 0).
