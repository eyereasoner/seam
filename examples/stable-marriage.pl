% Stable-marriage search with explicit blocking-pair detection.
% matching/1 enumerates all one-to-one pairings for four men and four women.
% blocking_pair/3 encodes instability: two people would both prefer each other over their assigned partners.
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

perm([], []).
perm(Items, [X|Rest]) :-
  select(X, Items, Remaining),
  perm(Remaining, Rest).

matching([
  pair(adam, W1),
  pair(brian, W2),
  pair(cole, W3),
  pair(drew, W4)
]) :-
  perm([amy, bea, cora, dana], [W1, W2, W3, W4]).

assigned(Matching, Man, Woman) :- member(pair(Man, Woman), Matching).

prefers_man(Man, Candidate, Current) :-
  rank_man(Man, Candidate, CandidateRank),
  rank_man(Man, Current, CurrentRank),
  lt(CandidateRank, CurrentRank).

prefers_woman(Woman, Candidate, Current) :-
  rank_woman(Woman, Candidate, CandidateRank),
  rank_woman(Woman, Current, CurrentRank),
  lt(CandidateRank, CurrentRank).

blocking_pair(Matching, Man, Woman) :-
  assigned(Matching, Man, CurrentWoman),
  woman(Woman),
  neq(Woman, CurrentWoman),
  prefers_man(Man, Woman, CurrentWoman),
  assigned(Matching, CurrentMan, Woman),
  prefers_woman(Woman, Man, CurrentMan).

stable_matching(Matching) :-
  matching(Matching),
  not(blocking_pair(Matching, _Man, _Woman)).

stable_marriage_answer(first_stable_matching, Matching) :- once(stable_matching(Matching)).
stable_marriage_answer(stable_matching_count, Count) :- countall(stable_matching(_Matching), Count).
