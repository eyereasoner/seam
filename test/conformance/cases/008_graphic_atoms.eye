% Reference 3.5, 5.2, 11: graphic atom constants are scalar terms.
materialize(value, 2).
raw_value(hash, #).
raw_value(arrow, =>).
raw_value(comparison, =<).
value(?k, ?v) :- raw_value(?k, ?v).
