% List collections inspired by the Eyeling collection example.
% Demonstrates list literals, member/2, length/2, append/3, and [Head|Tail].
% Each materialized relation demonstrates one list operation.
% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(length, 2).
materialize(member, 2).
materialize(append, 2).
materialize(head, 2).
materialize(tail, 2).

% The collection/2 facts keep complete lists as first-class terms rather than
% expanding them into separate item facts.
% Lists are first-class terms in facts and rule heads/bodies.
collection(numbers, [1, 2, 3]).
collection(letters, [a, b]).

% The derived predicates show list length, membership, append, and pattern
% matching with [Head|Tail] in the smallest possible setting.
length(numbers, ?n) :-
  collection(numbers, ?list),
  length(?list, ?n).

member(numbers, ?x) :-
  collection(numbers, ?list),
  member(?x, ?list).

append(letters, ?extended) :-
  collection(letters, ?list),
  append(?list, [c], ?extended).

head(letters, ?head) :-
  collection(letters, [?head|?_tail]).

tail(letters, ?tail) :-
  collection(letters, [?_head|?tail]).
