answer(table_path_bound, b).
why(
  answer(table_path_bound, b),
  proof(
    goal(answer(table_path_bound, b)),
    by(rule("<stdin>", clause(7))),
    bindings([binding("?x", b)]),
    uses([
      proof(
        goal(path(a, b)),
        by(rule("<stdin>", clause(5))),
        bindings([binding("?x", a), binding("?y", b)]),
        uses([
          proof(
            goal(edge(a, b)),
            by(fact("<stdin>", clause(3)))
          )
        ])
      )
    ])
  )
).

answer(table_path_bound, c).
why(
  answer(table_path_bound, c),
  proof(
    goal(answer(table_path_bound, c)),
    by(rule("<stdin>", clause(7))),
    bindings([binding("?x", c)]),
    uses([
      proof(
        goal(path(a, c)),
        by(rule("<stdin>", clause(6))),
        bindings([binding("?x", a), binding("?z", c), binding("?y", b)]),
        uses([
          proof(
            goal(edge(a, b)),
            by(fact("<stdin>", clause(3)))
          ),
          proof(
            goal(path(b, c)),
            by(rule("<stdin>", clause(5))),
            bindings([binding("?x", b), binding("?y", c)]),
            uses([
              proof(
                goal(edge(b, c)),
                by(fact("<stdin>", clause(4)))
              )
            ])
          )
        ])
      )
    ])
  )
).

