answer(nested_list_binding, [c]).
why(
  answer(nested_list_binding, [c]),
  proof(
    goal(answer(nested_list_binding, [c])),
    by(rule("<stdin>", clause(2))),
    bindings([binding("?tail", [c])]),
    uses([
      proof(
        goal(eq([a, b, c], [a, b, c])),
        by(builtin(eq, 2))
      )
    ])
  )
).

