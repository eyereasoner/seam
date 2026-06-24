% Four-colour search for the European Union neighbour graph.
%
% This is a finite executable version of the source map-colouring example.  The
% neighbour facts are the EU country graph from the original input, represented
% with lowercase atom names.  `once/1` asks for one valid colouring rather than
% enumerating all possible four-colour assignments.

materialize(four_color_answer, 2).

color(red).
color(green).
color(blue).
color(yellow).

place_order([belgium, netherlands, luxemburg, france, germany, italy, denmark, ireland, greece, spain, portugal, austria, sweden, finland, cyprus, malta, poland, hungary, czech_republic, slovakia, slovenia, estonia, latvia, lithuania, bulgaria, romania, croatia]).

neighbours(belgium, [france, netherlands, luxemburg, germany]).
neighbours(netherlands, [belgium, germany]).
neighbours(luxemburg, [belgium, france, germany]).
neighbours(france, [spain, belgium, luxemburg, germany, italy]).
neighbours(germany, [netherlands, belgium, luxemburg, denmark, france, austria, poland, czech_republic]).
neighbours(italy, [france, austria, slovenia]).
neighbours(denmark, [germany]).
neighbours(ireland, []).
neighbours(greece, [bulgaria]).
neighbours(spain, [france, portugal]).
neighbours(portugal, [spain]).
neighbours(austria, [czech_republic, germany, hungary, italy, slovenia, slovakia]).
neighbours(sweden, [finland]).
neighbours(finland, [sweden]).
neighbours(cyprus, []).
neighbours(malta, []).
neighbours(poland, [germany, czech_republic, slovakia, lithuania]).
neighbours(hungary, [austria, slovakia, romania, croatia, slovenia]).
neighbours(czech_republic, [germany, poland, slovakia, austria]).
neighbours(slovakia, [czech_republic, poland, hungary, austria]).
neighbours(slovenia, [austria, italy, hungary, croatia]).
neighbours(estonia, [latvia]).
neighbours(latvia, [estonia, lithuania]).
neighbours(lithuania, [latvia, poland]).
neighbours(bulgaria, [romania, greece]).
neighbours(romania, [hungary, bulgaria]).
neighbours(croatia, [slovenia, hungary]).

% Colour the tail first, like the source Prolog program.  That gives each
% colour choice the already-coloured suffix to check against and avoids
% generating many doomed prefixes.
valid_color(?place, ?color, ?assigned) :-
  neighbours(?place, ?neighbors),
  not((member([?neighbor, ?color], ?assigned), member(?neighbor, ?neighbors))).

place_pairs([], []).
place_pairs([?place|?rest], [[?place, ?]|?pairs]) :-
  place_pairs(?rest, ?pairs).

color_places([]).
color_places([[?place, ?color]|?tail]) :-
  color_places(?tail),
  color(?color),
  valid_color(?place, ?color, ?tail).

four_color_answer(european_union, ?coloring) :-
  place_order(?places),
  place_pairs(?places, ?coloring),
  once(color_places(?coloring)).
