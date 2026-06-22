% Stable-marriage search with explicit blocking-pair detection.
%
% matching/1 enumerates one-to-one pairings for four men and four women.  A
% pairing is stable precisely when no blocking pair exists: two people who would
% both prefer each other over their assigned partners.
materialize(stable_marriage_answer, 2).

man(adam).
man(brian).
man(cole).
man(drew).

woman(amy).
woman(bea).
woman(cora).
woman(dana).

rank_man(adam, bea, 1).
rank_man(adam, amy, 2).
rank_man(adam, dana, 3).
rank_man(adam, cora, 4).
rank_man(brian, amy, 1).
rank_man(brian, cora, 2).
rank_man(brian, bea, 3).
rank_man(brian, dana, 4).
rank_man(cole, amy, 1).
rank_man(cole, bea, 2).
rank_man(cole, dana, 3).
rank_man(cole, cora, 4).
rank_man(drew, cora, 1).
rank_man(drew, dana, 2).
rank_man(drew, bea, 3).
rank_man(drew, amy, 4).

rank_woman(amy, cole, 1).
rank_woman(amy, adam, 2).
rank_woman(amy, brian, 3).
rank_woman(amy, drew, 4).
rank_woman(bea, adam, 1).
rank_woman(bea, cole, 2).
rank_woman(bea, drew, 3).
rank_woman(bea, brian, 4).
rank_woman(cora, drew, 1).
rank_woman(cora, brian, 2).
rank_woman(cora, adam, 3).
rank_woman(cora, cole, 4).
rank_woman(dana, brian, 1).
rank_woman(dana, drew, 2).
rank_woman(dana, cole, 3).
rank_woman(dana, adam, 4).

% Permutations give every complete one-to-one matching over the four women.
perm([], []).
perm(?items, [?x|?rest]) :-
  select(?x, ?items, ?remaining),
  perm(?remaining, ?rest).

matching([
  pair(adam, ?w1),
  pair(brian, ?w2),
  pair(cole, ?w3),
  pair(drew, ?w4)
]) :-
  perm([amy, bea, cora, dana], [?w1, ?w2, ?w3, ?w4]).

assigned(?matching, ?man, ?woman) :- member(pair(?man, ?woman), ?matching).

prefers_man(?man, ?candidate, ?current) :-
  rank_man(?man, ?candidate, ?candidaterank),
  rank_man(?man, ?current, ?currentrank),
  lt(?candidaterank, ?currentrank).

prefers_woman(?woman, ?candidate, ?current) :-
  rank_woman(?woman, ?candidate, ?candidaterank),
  rank_woman(?woman, ?current, ?currentrank),
  lt(?candidaterank, ?currentrank).

% A blocking pair witnesses instability of a candidate matching.
blocking_pair(?matching, ?man, ?woman) :-
  assigned(?matching, ?man, ?currentwoman),
  woman(?woman),
  neq(?woman, ?currentwoman),
  prefers_man(?man, ?woman, ?currentwoman),
  assigned(?matching, ?currentman, ?woman),
  prefers_woman(?woman, ?man, ?currentman).

stable_matching(?matching) :-
  matching(?matching),
  not(blocking_pair(?matching, ?_man, ?_woman)).

stable_marriage_answer(first_stable_matching, ?matching) :- once(stable_matching(?matching)).
stable_marriage_answer(stable_matching_count, ?count) :- countall(stable_matching(?_matching), ?count).
