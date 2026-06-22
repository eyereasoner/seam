ancestor(pat, jan).
why(
  ancestor(pat, jan),
  proof(
    goal(ancestor(pat, jan)),
    by(rule("socket-family.eye", clause(6))),
    bindings([binding("?x", pat), binding("?y", jan)]),
    uses([
      proof(
        goal(parent(pat, jan)),
        by(fact("socket-family.eye", clause(4)))
      )
    ])
  )
).

ancestor(jan, emma).
why(
  ancestor(jan, emma),
  proof(
    goal(ancestor(jan, emma)),
    by(rule("socket-family.eye", clause(6))),
    bindings([binding("?x", jan), binding("?y", emma)]),
    uses([
      proof(
        goal(parent(jan, emma)),
        by(fact("socket-family.eye", clause(5)))
      )
    ])
  )
).

ancestor(pat, emma).
why(
  ancestor(pat, emma),
  proof(
    goal(ancestor(pat, emma)),
    by(rule("socket-family.eye", clause(7))),
    bindings([binding("?x", pat), binding("?z", emma), binding("?y", jan)]),
    uses([
      proof(
        goal(parent(pat, jan)),
        by(fact("socket-family.eye", clause(4)))
      ),
      proof(
        goal(ancestor(jan, emma)),
        by(rule("socket-family.eye", clause(6))),
        bindings([binding("?x", jan), binding("?y", emma)]),
        uses([
          proof(
            goal(parent(jan, emma)),
            by(fact("socket-family.eye", clause(5)))
          )
        ])
      )
    ])
  )
).

