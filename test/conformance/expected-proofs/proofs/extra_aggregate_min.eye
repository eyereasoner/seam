answer(aggregate_min, 1, a).
why(
  answer(aggregate_min, 1, a),
  proof(
    goal(answer(aggregate_min, 1, a)),
    by(rule("<stdin>", clause(4))),
    bindings([binding("?key", 1), binding("?value", a)]),
    uses([
      proof(
        goal(aggregate_min(?k, ?v, score(?k, ?v), 1, a)),
        by(builtin(aggregate_min, 5))
      )
    ])
  )
).

