violation(alice, missed_obligation(obtain_consent)).
why(
  violation(alice, missed_obligation(obtain_consent)),
  proof(
    goal(violation(alice, missed_obligation(obtain_consent))),
    by(rule("deontic-logic.eye", clause(14))),
    bindings([binding("?actor", alice), binding("?action", obtain_consent)]),
    uses([
      proof(
        goal(obliged(alice, obtain_consent)),
        by(fact("deontic-logic.eye", clause(7)))
      ),
      proof(
        goal(not_performed(alice, obtain_consent)),
        by(fact("deontic-logic.eye", clause(12)))
      )
    ])
  )
).

violation(alice, prohibited_action(share_record)).
why(
  violation(alice, prohibited_action(share_record)),
  proof(
    goal(violation(alice, prohibited_action(share_record))),
    by(rule("deontic-logic.eye", clause(15))),
    bindings([binding("?actor", alice), binding("?action", share_record)]),
    uses([
      proof(
        goal(prohibited(alice, share_record)),
        by(fact("deontic-logic.eye", clause(8)))
      ),
      proof(
        goal(performed(alice, share_record)),
        by(fact("deontic-logic.eye", clause(10)))
      )
    ])
  )
).

compensation(alice, compensation(share_record, notify_dpo)).
why(
  compensation(alice, compensation(share_record, notify_dpo)),
  proof(
    goal(compensation(alice, compensation(share_record, notify_dpo))),
    by(rule("deontic-logic.eye", clause(19))),
    bindings([binding("?actor", alice), binding("?action", share_record), binding("?compensation", notify_dpo)]),
    uses([
      proof(
        goal(compensated_violation(alice, share_record, notify_dpo)),
        by(rule("deontic-logic.eye", clause(16))),
        bindings([binding("?actor", alice), binding("?action", share_record), binding("?compensation", notify_dpo)]),
        uses([
          proof(
            goal(prohibited(alice, share_record)),
            by(fact("deontic-logic.eye", clause(8)))
          ),
          proof(
            goal(performed(alice, share_record)),
            by(fact("deontic-logic.eye", clause(10)))
          ),
          proof(
            goal(compensates(share_record, notify_dpo)),
            by(fact("deontic-logic.eye", clause(9)))
          ),
          proof(
            goal(performed(alice, notify_dpo)),
            by(fact("deontic-logic.eye", clause(11)))
          )
        ])
      )
    ])
  )
).

status(alice, requires_review).
why(
  status(alice, requires_review),
  proof(
    goal(status(alice, requires_review)),
    by(rule("deontic-logic.eye", clause(20))),
    bindings([binding("?actor", alice), binding("?_violation", missed_obligation(obtain_consent))]),
    uses([
      proof(
        goal(uncompensated_violation(alice, missed_obligation(obtain_consent))),
        by(rule("deontic-logic.eye", clause(17))),
        bindings([binding("?actor", alice), binding("?action", obtain_consent)]),
        uses([
          proof(
            goal(violation(alice, missed_obligation(obtain_consent))),
            by(rule("deontic-logic.eye", clause(14))),
            bindings([binding("?actor", alice), binding("?action", obtain_consent)]),
            uses([
              proof(
                goal(obliged(alice, obtain_consent)),
                by(fact("deontic-logic.eye", clause(7)))
              ),
              proof(
                goal(not_performed(alice, obtain_consent)),
                by(fact("deontic-logic.eye", clause(12)))
              )
            ])
          )
        ])
      )
    ])
  )
).

