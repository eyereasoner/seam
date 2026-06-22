sameInverse(x, i, j).
why(
  sameInverse(x, i, j),
  proof(
    goal(sameInverse(x, i, j)),
    by(rule("group-inverse-uniqueness.eye", clause(17))),
    bindings([binding("?a", x), binding("?b", i), binding("?c", j)]),
    uses([
      proof(
        goal(leftInverse(x, i)),
        by(rule("group-inverse-uniqueness.eye", clause(15))),
        bindings([binding("?a", x), binding("?b", i)]),
        uses([
          proof(
            goal(op(i, x, e)),
            by(fact("group-inverse-uniqueness.eye", clause(8)))
          )
        ])
      ),
      proof(
        goal(rightInverse(x, j)),
        by(rule("group-inverse-uniqueness.eye", clause(16))),
        bindings([binding("?a", x), binding("?b", j)]),
        uses([
          proof(
            goal(op(x, j, e)),
            by(fact("group-inverse-uniqueness.eye", clause(9)))
          )
        ])
      ),
      proof(
        goal(sameTerm(i, j)),
        by(fact("group-inverse-uniqueness.eye", clause(13)))
      ),
      proof(
        goal(neq(i, j)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameInverse(x, j, i).
why(
  sameInverse(x, j, i),
  proof(
    goal(sameInverse(x, j, i)),
    by(rule("group-inverse-uniqueness.eye", clause(17))),
    bindings([binding("?a", x), binding("?b", j), binding("?c", i)]),
    uses([
      proof(
        goal(leftInverse(x, j)),
        by(rule("group-inverse-uniqueness.eye", clause(15))),
        bindings([binding("?a", x), binding("?b", j)]),
        uses([
          proof(
            goal(op(j, x, e)),
            by(fact("group-inverse-uniqueness.eye", clause(10)))
          )
        ])
      ),
      proof(
        goal(rightInverse(x, i)),
        by(rule("group-inverse-uniqueness.eye", clause(16))),
        bindings([binding("?a", x), binding("?b", i)]),
        uses([
          proof(
            goal(op(x, i, e)),
            by(fact("group-inverse-uniqueness.eye", clause(11)))
          )
        ])
      ),
      proof(
        goal(sameTerm(j, i)),
        by(fact("group-inverse-uniqueness.eye", clause(14)))
      ),
      proof(
        goal(neq(j, i)),
        by(builtin(neq, 2))
      )
    ])
  )
).

