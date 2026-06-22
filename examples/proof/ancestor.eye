ancestor(pat, jan).
why(
  ancestor(pat, jan),
  proof(
    goal(ancestor(pat, jan)),
    by(rule("ancestor.eye", clause(6))),
    bindings([binding("?x", pat), binding("?y", jan)]),
    uses([
      proof(
        goal(parent(pat, jan)),
        by(fact("ancestor.eye", clause(3)))
      )
    ])
  )
).

ancestor(jan, lies).
why(
  ancestor(jan, lies),
  proof(
    goal(ancestor(jan, lies)),
    by(rule("ancestor.eye", clause(6))),
    bindings([binding("?x", jan), binding("?y", lies)]),
    uses([
      proof(
        goal(parent(jan, lies)),
        by(fact("ancestor.eye", clause(4)))
      )
    ])
  )
).

ancestor(lies, emma).
why(
  ancestor(lies, emma),
  proof(
    goal(ancestor(lies, emma)),
    by(rule("ancestor.eye", clause(6))),
    bindings([binding("?x", lies), binding("?y", emma)]),
    uses([
      proof(
        goal(parent(lies, emma)),
        by(fact("ancestor.eye", clause(5)))
      )
    ])
  )
).

ancestor(pat, lies).
why(
  ancestor(pat, lies),
  proof(
    goal(ancestor(pat, lies)),
    by(rule("ancestor.eye", clause(7))),
    bindings([binding("?x", pat), binding("?z", lies), binding("?y", jan)]),
    uses([
      proof(
        goal(parent(pat, jan)),
        by(fact("ancestor.eye", clause(3)))
      ),
      proof(
        goal(ancestor(jan, lies)),
        by(rule("ancestor.eye", clause(6))),
        bindings([binding("?x", jan), binding("?y", lies)]),
        uses([
          proof(
            goal(parent(jan, lies)),
            by(fact("ancestor.eye", clause(4)))
          )
        ])
      )
    ])
  )
).

ancestor(pat, emma).
why(
  ancestor(pat, emma),
  proof(
    goal(ancestor(pat, emma)),
    by(rule("ancestor.eye", clause(7))),
    bindings([binding("?x", pat), binding("?z", emma), binding("?y", jan)]),
    uses([
      proof(
        goal(parent(pat, jan)),
        by(fact("ancestor.eye", clause(3)))
      ),
      proof(
        goal(ancestor(jan, emma)),
        by(rule("ancestor.eye", clause(7))),
        bindings([binding("?x", jan), binding("?z", emma), binding("?y", lies)]),
        uses([
          proof(
            goal(parent(jan, lies)),
            by(fact("ancestor.eye", clause(4)))
          ),
          proof(
            goal(ancestor(lies, emma)),
            by(rule("ancestor.eye", clause(6))),
            bindings([binding("?x", lies), binding("?y", emma)]),
            uses([
              proof(
                goal(parent(lies, emma)),
                by(fact("ancestor.eye", clause(5)))
              )
            ])
          )
        ])
      )
    ])
  )
).

ancestor(jan, emma).
why(
  ancestor(jan, emma),
  proof(
    goal(ancestor(jan, emma)),
    by(rule("ancestor.eye", clause(7))),
    bindings([binding("?x", jan), binding("?z", emma), binding("?y", lies)]),
    uses([
      proof(
        goal(parent(jan, lies)),
        by(fact("ancestor.eye", clause(4)))
      ),
      proof(
        goal(ancestor(lies, emma)),
        by(rule("ancestor.eye", clause(6))),
        bindings([binding("?x", lies), binding("?y", emma)]),
        uses([
          proof(
            goal(parent(lies, emma)),
            by(fact("ancestor.eye", clause(5)))
          )
        ])
      )
    ])
  )
).

