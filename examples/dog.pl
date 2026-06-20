% Dog-license rule adapted from Eyeling dog.n3.
% hasDog/2 facts are counted per subject with countall/2.  The compliance rule
% derives mustHave(Subject, dogLicense) exactly for subjects with more than four
% registered dogs.

materialize(mustHave, 2).

% Dog-license example adapted from Eyeling dog.n3.
% A subject with more than four dogs must have a dog license.

hasDog(alice, dog1).
hasDog(alice, dog2).
hasDog(alice, dog3).
hasDog(alice, dog4).
hasDog(alice, dog5).
hasDog(bob, dog6).
hasDog(bob, dog7).

% countall/2 counts all matching dogs for the same subject.
dogCount(Subject, Count) :-
  hasDog(Subject, _Any),
  countall(hasDog(Subject, _Dog), Count).

mustHave(Subject, dogLicense) :-
  dogCount(Subject, Count),
  gt(Count, 4).
