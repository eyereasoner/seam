intuitionistic_truth(monotone_p_reaches_both, both, atom(p)).
why(
  intuitionistic_truth(monotone_p_reaches_both, both, atom(p)),
  proof(
    goal(intuitionistic_truth(monotone_p_reaches_both, both, atom(p))),
    by(rule("intuitionistic-logic-kripke.eye", clause(24))),
    uses([
      proof(
        goal(forces(both, atom(p))),
        by(rule("intuitionistic-logic-kripke.eye", clause(17))),
        bindings([binding("?world", both), binding("?prop", p), binding("?someworld", left)]),
        uses([
          proof(
            goal(leq(left, both)),
            by(rule("intuitionistic-logic-kripke.eye", clause(16))),
            bindings([binding("?from", left), binding("?to", both), binding("?mid", both)]),
            uses([
              proof(
                goal(step(left, both)),
                by(fact("intuitionistic-logic-kripke.eye", clause(11)))
              ),
              proof(
                goal(leq(both, both)),
                by(rule("intuitionistic-logic-kripke.eye", clause(15))),
                bindings([binding("?world", both)]),
                uses([
                  proof(
                    goal(world(both)),
                    by(fact("intuitionistic-logic-kripke.eye", clause(8)))
                  )
                ])
              )
            ])
          ),
          proof(
            goal(base(left, p)),
            by(fact("intuitionistic-logic-kripke.eye", clause(13)))
          )
        ])
      )
    ])
  )
).

intuitionistic_truth(constructive_case_analysis, root, implies(atom(p), or(atom(p), atom(q)))).
why(
  intuitionistic_truth(constructive_case_analysis, root, implies(atom(p), or(atom(p), atom(q)))),
  proof(
    goal(intuitionistic_truth(constructive_case_analysis, root, implies(atom(p), or(atom(p), atom(q))))),
    by(rule("intuitionistic-logic-kripke.eye", clause(25))),
    uses([
      proof(
        goal(forces(root, implies(atom(p), or(atom(p), atom(q))))),
        by(rule("intuitionistic-logic-kripke.eye", clause(21))),
        bindings([binding("?world", root), binding("?left", atom(p)), binding("?right", or(atom(p), atom(q)))]),
        uses([
          proof(
            goal(world(root)),
            by(fact("intuitionistic-logic-kripke.eye", clause(5)))
          ),
          proof(
            goal(not(bad_implication(root, atom(p), or(atom(p), atom(q))))),
            by(builtin(not, 1))
          )
        ])
      )
    ])
  )
).

intuitionistic_truth(double_negated_branch_information, root, neg(neg(or(atom(p), atom(q))))).
why(
  intuitionistic_truth(double_negated_branch_information, root, neg(neg(or(atom(p), atom(q))))),
  proof(
    goal(intuitionistic_truth(double_negated_branch_information, root, neg(neg(or(atom(p), atom(q)))))),
    by(rule("intuitionistic-logic-kripke.eye", clause(26))),
    uses([
      proof(
        goal(forces(root, neg(neg(or(atom(p), atom(q)))))),
        by(rule("intuitionistic-logic-kripke.eye", clause(22))),
        bindings([binding("?world", root), binding("?formula", neg(or(atom(p), atom(q))))]),
        uses([
          proof(
            goal(forces(root, implies(neg(or(atom(p), atom(q))), bottom))),
            by(rule("intuitionistic-logic-kripke.eye", clause(21))),
            bindings([binding("?world", root), binding("?left", neg(or(atom(p), atom(q)))), binding("?right", bottom)]),
            uses([
              proof(
                goal(world(root)),
                by(fact("intuitionistic-logic-kripke.eye", clause(5)))
              ),
              proof(
                goal(not(bad_implication(root, neg(or(atom(p), atom(q))), bottom))),
                by(builtin(not, 1))
              )
            ])
          )
        ])
      )
    ])
  )
).

intuitionistic_countermodel(root_does_not_decide_branch, root, or(atom(p), atom(q))).
why(
  intuitionistic_countermodel(root_does_not_decide_branch, root, or(atom(p), atom(q))),
  proof(
    goal(intuitionistic_countermodel(root_does_not_decide_branch, root, or(atom(p), atom(q)))),
    by(rule("intuitionistic-logic-kripke.eye", clause(27))),
    uses([
      proof(
        goal(not(forces(root, or(atom(p), atom(q))))),
        by(builtin(not, 1))
      )
    ])
  )
).

intuitionistic_countermodel(excluded_middle_not_forced, root, or(atom(p), neg(atom(p)))).
why(
  intuitionistic_countermodel(excluded_middle_not_forced, root, or(atom(p), neg(atom(p)))),
  proof(
    goal(intuitionistic_countermodel(excluded_middle_not_forced, root, or(atom(p), neg(atom(p))))),
    by(rule("intuitionistic-logic-kripke.eye", clause(28))),
    uses([
      proof(
        goal(not(forces(root, or(atom(p), neg(atom(p)))))),
        by(builtin(not, 1))
      )
    ])
  )
).

