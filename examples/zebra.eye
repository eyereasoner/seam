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
  eq(?houses, [?_, ?_, ?_, ?_, ?_]),
  first(?houses, house(?_, norwegian, ?_, ?_, ?_)),
  third(?houses, house(?_, ?_, ?_, milk, ?_)),
  adjacent(house(?_, norwegian, ?_, ?_, ?_), house(blue, ?_, ?_, ?_, ?_), ?houses),
  next_to(house(ivory, ?_, ?_, ?_, ?_), house(green, ?_, ?_, ?_, ?_), ?houses),
  member(house(red, english, ?_, ?_, ?_), ?houses),
  member(house(green, ?_, ?_, coffee, ?_), ?houses),
  member(house(yellow, ?_, ?_, ?_, kools), ?houses),
  member(house(?_, spanish, dog, ?_, ?_), ?houses),
  member(house(?_, ukrainian, ?_, tea, ?_), ?houses),
  member(house(?_, ?_, snail, ?_, old_gold), ?houses),
  adjacent(house(?_, ?_, ?_, ?_, chesterfields), house(?_, ?_, fox, ?_, ?_), ?houses),
  adjacent(house(?_, ?_, ?_, ?_, kools), house(?_, ?_, horse, ?_, ?_), ?houses),
  member(house(?_, ?_, ?_, orange_juice, lucky_strike), ?houses),
  member(house(?_, japanese, ?_, ?_, parliaments), ?houses),
  member(house(?_, ?waterdrinker, ?_, water, ?_), ?houses),
  member(house(?_, ?zebraowner, zebra, ?_, ?_), ?houses).

% Positional and neighborhood helpers keep the clue encoding readable.
first([?x|?_], ?x).
third([?_, ?_, ?x|?_], ?x).

adjacent(?a, ?b, ?list) :- next_to(?a, ?b, ?list).
adjacent(?a, ?b, ?list) :- next_to(?b, ?a, ?list).

next_to(?x, ?y, [?x, ?y|?_]).
next_to(?x, ?y, [?_|?zs]) :- next_to(?x, ?y, ?zs).

waterDrinker(zebraPuzzle, ?waterdrinker) :- zebra(?waterdrinker, ?_zebraowner).
zebraOwner(zebraPuzzle, ?zebraowner) :- zebra(?_waterdrinker, ?zebraowner).
solved(zebraPuzzle, true) :- zebra(norwegian, japanese).
