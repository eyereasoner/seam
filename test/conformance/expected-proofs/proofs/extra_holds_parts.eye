answer(holds_parts, alpha, []).
why(
  answer(holds_parts, alpha, []),
  proof(
    goal(answer(holds_parts, alpha, [])),
    by(rule("<stdin>", clause(2))),
    bindings([binding("?name", alpha), binding("?args", [])]),
    uses([
      proof(
        goal(holds((alpha, beta(2)), alpha, [])),
        by(builtin(holds, 3))
      )
    ])
  )
).

answer(holds_parts, beta, [2]).
why(
  answer(holds_parts, beta, [2]),
  proof(
    goal(answer(holds_parts, beta, [2])),
    by(rule("<stdin>", clause(2))),
    bindings([binding("?name", beta), binding("?args", [2])]),
    uses([
      proof(
        goal(holds((alpha, beta(2)), beta, [2])),
        by(builtin(holds, 3))
      )
    ])
  )
).

