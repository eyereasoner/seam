status(case_alpha, gdpr_compliant).
why(
  status(case_alpha, gdpr_compliant),
  proof(
    goal(status(case_alpha, gdpr_compliant)),
    by(rule("gdpr-compliance.eye", clause(27))),
    bindings([binding("?case", case_alpha)]),
    uses([
      proof(
        goal(compliant(case_alpha)),
        by(rule("gdpr-compliance.eye", clause(22))),
        bindings([binding("?case", case_alpha)]),
        uses([
          proof(
            goal(processing(case_alpha)),
            by(fact("gdpr-compliance.eye", clause(3)))
          ),
          proof(
            goal(has_required_basis(case_alpha)),
            by(rule("gdpr-compliance.eye", clause(17))),
            bindings([binding("?case", case_alpha)]),
            uses([
              proof(
                goal(legal_basis(case_alpha, explicit_consent)),
                by(fact("gdpr-compliance.eye", clause(7)))
              )
            ])
          ),
          proof(
            goal(minimized(case_alpha)),
            by(fact("gdpr-compliance.eye", clause(8)))
          ),
          proof(
            goal(has_health_safeguards(case_alpha)),
            by(rule("gdpr-compliance.eye", clause(19))),
            bindings([binding("?case", case_alpha)]),
            uses([
              proof(
                goal(special_category(case_alpha, health_data)),
                by(fact("gdpr-compliance.eye", clause(10)))
              ),
              proof(
                goal(safeguard(case_alpha, encryption)),
                by(fact("gdpr-compliance.eye", clause(12)))
              ),
              proof(
                goal(safeguard(case_alpha, access_logging)),
                by(fact("gdpr-compliance.eye", clause(13)))
              )
            ])
          ),
          proof(
            goal(transfer_ok(case_alpha)),
            by(rule("gdpr-compliance.eye", clause(20))),
            bindings([binding("?case", case_alpha)]),
            uses([
              proof(
                goal(not(third_country_transfer(case_alpha))),
                by(builtin(not, 1))
              )
            ])
          )
        ])
      )
    ])
  )
).

status(case_beta, gdpr_noncompliant).
why(
  status(case_beta, gdpr_noncompliant),
  proof(
    goal(status(case_beta, gdpr_noncompliant)),
    by(rule("gdpr-compliance.eye", clause(28))),
    bindings([binding("?case", case_beta), binding("?_reason", missing_legal_basis)]),
    uses([
      proof(
        goal(noncompliance_reason(case_beta, missing_legal_basis)),
        by(rule("gdpr-compliance.eye", clause(23))),
        bindings([binding("?case", case_beta)]),
        uses([
          proof(
            goal(processing(case_beta)),
            by(fact("gdpr-compliance.eye", clause(4)))
          ),
          proof(
            goal(not(has_required_basis(case_beta))),
            by(builtin(not, 1))
          )
        ])
      )
    ])
  )
).

reason(case_beta, missing_legal_basis).
why(
  reason(case_beta, missing_legal_basis),
  proof(
    goal(reason(case_beta, missing_legal_basis)),
    by(rule("gdpr-compliance.eye", clause(29))),
    bindings([binding("?case", case_beta), binding("?reason", missing_legal_basis)]),
    uses([
      proof(
        goal(noncompliance_reason(case_beta, missing_legal_basis)),
        by(rule("gdpr-compliance.eye", clause(23))),
        bindings([binding("?case", case_beta)]),
        uses([
          proof(
            goal(processing(case_beta)),
            by(fact("gdpr-compliance.eye", clause(4)))
          ),
          proof(
            goal(not(has_required_basis(case_beta))),
            by(builtin(not, 1))
          )
        ])
      )
    ])
  )
).

reason(case_beta, not_minimized).
why(
  reason(case_beta, not_minimized),
  proof(
    goal(reason(case_beta, not_minimized)),
    by(rule("gdpr-compliance.eye", clause(29))),
    bindings([binding("?case", case_beta), binding("?reason", not_minimized)]),
    uses([
      proof(
        goal(noncompliance_reason(case_beta, not_minimized)),
        by(rule("gdpr-compliance.eye", clause(24))),
        bindings([binding("?case", case_beta)]),
        uses([
          proof(
            goal(not_minimized(case_beta)),
            by(fact("gdpr-compliance.eye", clause(9)))
          )
        ])
      )
    ])
  )
).

reason(case_beta, missing_access_logging).
why(
  reason(case_beta, missing_access_logging),
  proof(
    goal(reason(case_beta, missing_access_logging)),
    by(rule("gdpr-compliance.eye", clause(29))),
    bindings([binding("?case", case_beta), binding("?reason", missing_access_logging)]),
    uses([
      proof(
        goal(noncompliance_reason(case_beta, missing_access_logging)),
        by(rule("gdpr-compliance.eye", clause(25))),
        bindings([binding("?case", case_beta)]),
        uses([
          proof(
            goal(special_category(case_beta, health_data)),
            by(fact("gdpr-compliance.eye", clause(11)))
          ),
          proof(
            goal(not(safeguard(case_beta, access_logging))),
            by(builtin(not, 1))
          )
        ])
      )
    ])
  )
).

reason(case_beta, transfer_without_adequacy).
why(
  reason(case_beta, transfer_without_adequacy),
  proof(
    goal(reason(case_beta, transfer_without_adequacy)),
    by(rule("gdpr-compliance.eye", clause(29))),
    bindings([binding("?case", case_beta), binding("?reason", transfer_without_adequacy)]),
    uses([
      proof(
        goal(noncompliance_reason(case_beta, transfer_without_adequacy)),
        by(rule("gdpr-compliance.eye", clause(26))),
        bindings([binding("?case", case_beta)]),
        uses([
          proof(
            goal(third_country_transfer(case_beta)),
            by(fact("gdpr-compliance.eye", clause(15)))
          ),
          proof(
            goal(not(adequacy_decision(case_beta))),
            by(builtin(not, 1))
          )
        ])
      )
    ])
  )
).

