materialize(answer, 2).
answer(?first, ?last) :- matches("Ada Lovelace", "^(?<first>[A-Za-z]+) (?<last>[A-Za-z]+)$", ?ctx), holds(?ctx, first, ?first), holds(?ctx, last, ?last).
