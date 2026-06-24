% Zebra puzzle, adapted from Eyelet's input/zebra.eye.
%
% Five houses are represented as house(Color, Nationality, Pet, Beverage,
% Cigarette).  Each clue is a member/2, first/2, third/2, next_to/3, or adjacent/3
% constraint over that list.  The answer is the classic one: the Norwegian drinks
% water and the Japanese owns the zebra.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(waterDrinker, 2).
materialize(zebraOwner, 2).
materialize(solved, 2).

% The single zebra/2 rule is a finite constraint model over the five house slots.
zebra(?waterdrinker, ?zebraowner) :-
  eq(?houses, [?, ?, ?, ?, ?]),
  first(?houses, house(?, norwegian, ?, ?, ?)),
  third(?houses, house(?, ?, ?, milk, ?)),
  adjacent(house(?, norwegian, ?, ?, ?), house(blue, ?, ?, ?, ?), ?houses),
  next_to(house(ivory, ?, ?, ?, ?), house(green, ?, ?, ?, ?), ?houses),
  member(house(red, english, ?, ?, ?), ?houses),
  member(house(green, ?, ?, coffee, ?), ?houses),
  member(house(yellow, ?, ?, ?, kools), ?houses),
  member(house(?, spanish, dog, ?, ?), ?houses),
  member(house(?, ukrainian, ?, tea, ?), ?houses),
  member(house(?, ?, snail, ?, old_gold), ?houses),
  adjacent(house(?, ?, ?, ?, chesterfields), house(?, ?, fox, ?, ?), ?houses),
  adjacent(house(?, ?, ?, ?, kools), house(?, ?, horse, ?, ?), ?houses),
  member(house(?, ?, ?, orange_juice, lucky_strike), ?houses),
  member(house(?, japanese, ?, ?, parliaments), ?houses),
  member(house(?, ?waterdrinker, ?, water, ?), ?houses),
  member(house(?, ?zebraowner, zebra, ?, ?), ?houses).

% Positional and neighborhood helpers keep the clue encoding readable.
first([?x|?], ?x).
third([?, ?, ?x|?], ?x).

adjacent(?a, ?b, ?list) :- next_to(?a, ?b, ?list).
adjacent(?a, ?b, ?list) :- next_to(?b, ?a, ?list).

next_to(?x, ?y, [?x, ?y|?]).
next_to(?x, ?y, [?|?zs]) :- next_to(?x, ?y, ?zs).

waterDrinker(zebraPuzzle, ?waterdrinker) :- zebra(?waterdrinker, ?_zebraowner).
zebraOwner(zebraPuzzle, ?zebraowner) :- zebra(?_waterdrinker, ?zebraowner).
solved(zebraPuzzle, true) :- zebra(norwegian, japanese).
