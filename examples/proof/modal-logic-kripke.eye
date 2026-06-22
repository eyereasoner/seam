modal_truth(all_accessible_worlds_clear, w0, box(atom(clear))).
why(
  modal_truth(all_accessible_worlds_clear, w0, box(atom(clear))),
  proof(
    goal(modal_truth(all_accessible_worlds_clear, w0, box(atom(clear)))),
    by(rule("modal-logic-kripke.eye", clause(22))),
    uses([
      proof(
        goal(mforces(w0, box(atom(clear)))),
        by(rule("modal-logic-kripke.eye", clause(21))),
        bindings([binding("?world", w0), binding("?formula", atom(clear))]),
        uses([
          proof(
            goal(world(w0)),
            by(fact("modal-logic-kripke.eye", clause(3)))
          ),
          proof(
            goal(forall(accessible(w0, ?next), mforces(?next, atom(clear)))),
            by(builtin(forall, 2))
          )
        ])
      )
    ])
  )
).

modal_truth(repair_is_possible, w0, diamond(atom(repaired))).
why(
  modal_truth(repair_is_possible, w0, diamond(atom(repaired))),
  proof(
    goal(modal_truth(repair_is_possible, w0, diamond(atom(repaired)))),
    by(rule("modal-logic-kripke.eye", clause(23))),
    uses([
      proof(
        goal(mforces(w0, diamond(atom(repaired)))),
        by(rule("modal-logic-kripke.eye", clause(20))),
        bindings([binding("?world", w0), binding("?formula", atom(repaired)), binding("?next", w2)]),
        uses([
          proof(
            goal(accessible(w0, w2)),
            by(fact("modal-logic-kripke.eye", clause(8)))
          ),
          proof(
            goal(mforces(w2, atom(repaired))),
            by(rule("modal-logic-kripke.eye", clause(18))),
            bindings([binding("?world", w2), binding("?prop", repaired)]),
            uses([
              proof(
                goal(true_at(w2, repaired)),
                by(fact("modal-logic-kripke.eye", clause(16)))
              )
            ])
          )
        ])
      )
    ])
  )
).

modal_truth(nested_possibility, w1, diamond(and(atom(clear), atom(clear)))).
why(
  modal_truth(nested_possibility, w1, diamond(and(atom(clear), atom(clear)))),
  proof(
    goal(modal_truth(nested_possibility, w1, diamond(and(atom(clear), atom(clear))))),
    by(rule("modal-logic-kripke.eye", clause(24))),
    uses([
      proof(
        goal(mforces(w1, diamond(and(atom(clear), atom(clear))))),
        by(rule("modal-logic-kripke.eye", clause(20))),
        bindings([binding("?world", w1), binding("?formula", and(atom(clear), atom(clear))), binding("?next", w1)]),
        uses([
          proof(
            goal(accessible(w1, w1)),
            by(fact("modal-logic-kripke.eye", clause(9)))
          ),
          proof(
            goal(mforces(w1, and(atom(clear), atom(clear)))),
            by(rule("modal-logic-kripke.eye", clause(19))),
            bindings([binding("?world", w1), binding("?left", atom(clear)), binding("?right", atom(clear))]),
            uses([
              proof(
                goal(mforces(w1, atom(clear))),
                by(rule("modal-logic-kripke.eye", clause(18))),
                bindings([binding("?world", w1), binding("?prop", clear)]),
                uses([
                  proof(
                    goal(true_at(w1, clear)),
                    by(fact("modal-logic-kripke.eye", clause(13)))
                  )
                ])
              ),
              proof(
                goal(mforces(w1, atom(clear))),
                by(rule("modal-logic-kripke.eye", clause(18))),
                bindings([binding("?world", w1), binding("?prop", clear)]),
                uses([
                  proof(
                    goal(true_at(w1, clear)),
                    by(fact("modal-logic-kripke.eye", clause(13)))
                  )
                ])
              )
            ])
          )
        ])
      )
    ])
  )
).

modal_countermodel(repair_not_necessary, w0).
why(
  modal_countermodel(repair_not_necessary, w0),
  proof(
    goal(modal_countermodel(repair_not_necessary, w0)),
    by(rule("modal-logic-kripke.eye", clause(25))),
    uses([
      proof(
        goal(not(mforces(w0, box(atom(repaired))))),
        by(builtin(not, 1))
      )
    ])
  )
).

