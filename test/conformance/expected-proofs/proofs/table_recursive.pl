path(a, b).
why(
  path(a, b),
  proof(
    goal(path(a, b)),
    by(rule("<stdin>", clause(5))),
    bindings([binding("X", a), binding("Y", b)]),
    uses([
      proof(
        goal(edge(a, b)),
        by(fact("<stdin>", clause(3)))
      )
    ])
  )
).

path(b, c).
why(
  path(b, c),
  proof(
    goal(path(b, c)),
    by(rule("<stdin>", clause(5))),
    bindings([binding("X", b), binding("Y", c)]),
    uses([
      proof(
        goal(edge(b, c)),
        by(fact("<stdin>", clause(4)))
      )
    ])
  )
).

path(a, c).
why(
  path(a, c),
  proof(
    goal(path(a, c)),
    by(rule("<stdin>", clause(6))),
    bindings([binding("X", a), binding("Z", c), binding("Y", b)]),
    uses([
      proof(
        goal(edge(a, b)),
        by(fact("<stdin>", clause(3)))
      ),
      proof(
        goal(path(b, c)),
        by(rule("<stdin>", clause(5))),
        bindings([binding("X", b), binding("Y", c)]),
        uses([
          proof(
            goal(edge(b, c)),
            by(fact("<stdin>", clause(4)))
          )
        ])
      )
    ])
  )
).

