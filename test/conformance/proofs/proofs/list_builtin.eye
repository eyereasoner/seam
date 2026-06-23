% Reference 12: proof output preserves list read-back for built-in goals.
materialize(answer, 1).
answer(?x) :- member(?x, [a, b]), eq(?x, b).
