result(root, 12).
why(
  result(root, 12),
  proof(
    goal(result(root, 12)),
    by(rule("expression-eval.eye", clause(14))),
    bindings([binding("?value", 12), binding("?node", eAdd)]),
    uses([
      proof(
        goal(root(eAdd)),
        by(fact("expression-eval.eye", clause(9)))
      ),
      proof(
        goal(value(eAdd, 12)),
        by(rule("expression-eval.eye", clause(11))),
        bindings([binding("?node", eAdd), binding("?value", 12), binding("?left", eMul), binding("?right", eSub), binding("?leftvalue", 6), binding("?rightvalue", 6)]),
        uses([
          proof(
            goal(expr(eAdd, add, eMul, eSub)),
            by(fact("expression-eval.eye", clause(8)))
          ),
          proof(
            goal(value(eMul, 6)),
            by(rule("expression-eval.eye", clause(13))),
            bindings([binding("?node", eMul), binding("?value", 6), binding("?left", n2), binding("?right", n3), binding("?leftvalue", 2), binding("?rightvalue", 3)]),
            uses([
              proof(
                goal(expr(eMul, mul, n2, n3)),
                by(fact("expression-eval.eye", clause(6)))
              ),
              proof(
                goal(value(n2, 2)),
                by(rule("expression-eval.eye", clause(10))),
                bindings([binding("?node", n2), binding("?value", 2)]),
                uses([
                  proof(
                    goal(number(n2, 2)),
                    by(fact("expression-eval.eye", clause(2)))
                  )
                ])
              ),
              proof(
                goal(value(n3, 3)),
                by(rule("expression-eval.eye", clause(10))),
                bindings([binding("?node", n3), binding("?value", 3)]),
                uses([
                  proof(
                    goal(number(n3, 3)),
                    by(fact("expression-eval.eye", clause(3)))
                  )
                ])
              ),
              proof(
                goal(mul(2, 3, 6)),
                by(builtin(mul, 3))
              )
            ])
          ),
          proof(
            goal(value(eSub, 6)),
            by(rule("expression-eval.eye", clause(12))),
            bindings([binding("?node", eSub), binding("?value", 6), binding("?left", n10), binding("?right", n4), binding("?leftvalue", 10), binding("?rightvalue", 4)]),
            uses([
              proof(
                goal(expr(eSub, sub, n10, n4)),
                by(fact("expression-eval.eye", clause(7)))
              ),
              proof(
                goal(value(n10, 10)),
                by(rule("expression-eval.eye", clause(10))),
                bindings([binding("?node", n10), binding("?value", 10)]),
                uses([
                  proof(
                    goal(number(n10, 10)),
                    by(fact("expression-eval.eye", clause(4)))
                  )
                ])
              ),
              proof(
                goal(value(n4, 4)),
                by(rule("expression-eval.eye", clause(10))),
                bindings([binding("?node", n4), binding("?value", 4)]),
                uses([
                  proof(
                    goal(number(n4, 4)),
                    by(fact("expression-eval.eye", clause(5)))
                  )
                ])
              ),
              proof(
                goal(sub(10, 4, 6)),
                by(builtin(sub, 3))
              )
            ])
          ),
          proof(
            goal(add(6, 6, 12)),
            by(builtin(add, 3))
          )
        ])
      )
    ])
  )
).

