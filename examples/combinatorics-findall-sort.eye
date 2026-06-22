% Eyelet-inspired combinations example using findall/3 and sort/2.
%
% combination/3 generates the same subset in several selection orders.  findall/3
% collects those candidates, and sort/2 canonicalizes the list so each unordered
% 3-combination of five items is reported once.
materialize(combinations, 2).
materialize(count, 2).
materialize(reason, 2).

% select/3 nondeterministically removes one item from a list; because it is an
% ordinary rule, the example also demonstrates user-level list recursion.
select(?item, [?item | ?rest], ?rest).
% The recursive clause keeps the non-selected head and searches the tail.
select(?item, [?head | ?tail], [?head | ?rest]) :-
  select(?item, ?tail, ?rest).

% combination/3 builds an unordered K-combination by repeated selection.
combination(0, ?_items, []).
combination(?i, ?items, ?combination) :-
  gt(?i, 0),
  select(?item, ?items, ?remaining),
  sub(?i, 1, ?j),
  combination(?j, ?remaining, ?partial),
  sort([?item | ?partial], ?combination).

% findall collects all generation orders; sort canonicalizes and deduplicates.
unique_combinations(?k, ?items, ?unique) :-
  findall(?c, combination(?k, ?items, ?c), ?all),
  sort(?all, ?unique).

combinations(combinations_5_choose_3, ?unique) :-
  unique_combinations(3, [1, 2, 3, 4, 5], ?unique).

count(combinations_5_choose_3, ?count) :-
  unique_combinations(3, [1, 2, 3, 4, 5], ?unique),
  length(?unique, ?count).

reason(combinations_5_choose_3, "findall gathers generated combinations and sort removes duplicates").
