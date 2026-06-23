answer(findall_builtin, [a, b]).
why(
  answer(findall_builtin, [a, b]),
  proof(
    goal(answer(findall_builtin, [a, b])),
    by(rule("<stdin>", clause(4))),
    bindings([binding("?bag", [a, b])]),
    uses([
      proof(
        goal(findall(?x, item(?x), [a, b])),
        by(builtin(findall, 3))
      )
    ])
  )
).

