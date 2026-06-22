type(p001, trial_candidate).
why(
  type(p001, trial_candidate),
  proof(
    goal(type(p001, trial_candidate)),
    by(rule("clinical-trial-screening.eye", clause(34))),
    bindings([binding("?patient", p001)]),
    uses([
      proof(
        goal(screen_eligible(p001)),
        by(rule("clinical-trial-screening.eye", clause(30))),
        bindings([binding("?patient", p001)]),
        uses([
          proof(
            goal(inclusion_adult(p001)),
            by(rule("clinical-trial-screening.eye", clause(25))),
            bindings([binding("?patient", p001), binding("?age", 54)]),
            uses([
              proof(
                goal(patient(p001)),
                by(fact("clinical-trial-screening.eye", clause(4)))
              ),
              proof(
                goal(age(p001, 54)),
                by(fact("clinical-trial-screening.eye", clause(8)))
              ),
              proof(
                goal(ge(54, 18)),
                by(builtin(ge, 2))
              )
            ])
          ),
          proof(
            goal(inclusion_diagnosis(p001)),
            by(rule("clinical-trial-screening.eye", clause(26))),
            bindings([binding("?patient", p001)]),
            uses([
              proof(
                goal(diagnosis(p001, type2_diabetes)),
                by(fact("clinical-trial-screening.eye", clause(12)))
              )
            ])
          ),
          proof(
            goal(inclusion_hba1c(p001)),
            by(rule("clinical-trial-screening.eye", clause(27))),
            bindings([binding("?patient", p001), binding("?hba1c", 8.4)]),
            uses([
              proof(
                goal(lab(p001, hba1c_pct, 8.4)),
                by(fact("clinical-trial-screening.eye", clause(16)))
              ),
              proof(
                goal(ge(8.4, 7.0)),
                by(builtin(ge, 2))
              ),
              proof(
                goal(le(8.4, 10.5)),
                by(builtin(le, 2))
              )
            ])
          ),
          proof(
            goal(not(exclusion_renal(p001))),
            by(builtin(not, 1))
          ),
          proof(
            goal(not(exclusion_pregnancy(p001))),
            by(builtin(not, 1))
          )
        ])
      )
    ])
  )
).

status(p001, eligible).
why(
  status(p001, eligible),
  proof(
    goal(status(p001, eligible)),
    by(rule("clinical-trial-screening.eye", clause(35))),
    bindings([binding("?patient", p001)]),
    uses([
      proof(
        goal(screen_eligible(p001)),
        by(rule("clinical-trial-screening.eye", clause(30))),
        bindings([binding("?patient", p001)]),
        uses([
          proof(
            goal(inclusion_adult(p001)),
            by(rule("clinical-trial-screening.eye", clause(25))),
            bindings([binding("?patient", p001), binding("?age", 54)]),
            uses([
              proof(
                goal(patient(p001)),
                by(fact("clinical-trial-screening.eye", clause(4)))
              ),
              proof(
                goal(age(p001, 54)),
                by(fact("clinical-trial-screening.eye", clause(8)))
              ),
              proof(
                goal(ge(54, 18)),
                by(builtin(ge, 2))
              )
            ])
          ),
          proof(
            goal(inclusion_diagnosis(p001)),
            by(rule("clinical-trial-screening.eye", clause(26))),
            bindings([binding("?patient", p001)]),
            uses([
              proof(
                goal(diagnosis(p001, type2_diabetes)),
                by(fact("clinical-trial-screening.eye", clause(12)))
              )
            ])
          ),
          proof(
            goal(inclusion_hba1c(p001)),
            by(rule("clinical-trial-screening.eye", clause(27))),
            bindings([binding("?patient", p001), binding("?hba1c", 8.4)]),
            uses([
              proof(
                goal(lab(p001, hba1c_pct, 8.4)),
                by(fact("clinical-trial-screening.eye", clause(16)))
              ),
              proof(
                goal(ge(8.4, 7.0)),
                by(builtin(ge, 2))
              ),
              proof(
                goal(le(8.4, 10.5)),
                by(builtin(le, 2))
              )
            ])
          ),
          proof(
            goal(not(exclusion_renal(p001))),
            by(builtin(not, 1))
          ),
          proof(
            goal(not(exclusion_pregnancy(p001))),
            by(builtin(not, 1))
          )
        ])
      )
    ])
  )
).

status(p002, screen_fail).
why(
  status(p002, screen_fail),
  proof(
    goal(status(p002, screen_fail)),
    by(rule("clinical-trial-screening.eye", clause(37))),
    bindings([binding("?patient", p002)]),
    uses([
      proof(
        goal(screen_fail(p002)),
        by(rule("clinical-trial-screening.eye", clause(31))),
        bindings([binding("?patient", p002)]),
        uses([
          proof(
            goal(exclusion_renal(p002)),
            by(rule("clinical-trial-screening.eye", clause(28))),
            bindings([binding("?patient", p002), binding("?egfr", 38.0)]),
            uses([
              proof(
                goal(lab(p002, egfr_ml_min, 38.0)),
                by(fact("clinical-trial-screening.eye", clause(21)))
              ),
              proof(
                goal(lt(38.0, 45.0)),
                by(builtin(lt, 2))
              )
            ])
          )
        ])
      )
    ])
  )
).

status(p003, screen_fail).
why(
  status(p003, screen_fail),
  proof(
    goal(status(p003, screen_fail)),
    by(rule("clinical-trial-screening.eye", clause(37))),
    bindings([binding("?patient", p003)]),
    uses([
      proof(
        goal(screen_fail(p003)),
        by(rule("clinical-trial-screening.eye", clause(32))),
        bindings([binding("?patient", p003)]),
        uses([
          proof(
            goal(exclusion_pregnancy(p003)),
            by(rule("clinical-trial-screening.eye", clause(29))),
            bindings([binding("?patient", p003)]),
            uses([
              proof(
                goal(condition(p003, pregnant)),
                by(fact("clinical-trial-screening.eye", clause(24)))
              )
            ])
          )
        ])
      )
    ])
  )
).

status(p004, screen_fail).
why(
  status(p004, screen_fail),
  proof(
    goal(status(p004, screen_fail)),
    by(rule("clinical-trial-screening.eye", clause(37))),
    bindings([binding("?patient", p004)]),
    uses([
      proof(
        goal(screen_fail(p004)),
        by(rule("clinical-trial-screening.eye", clause(33))),
        bindings([binding("?patient", p004)]),
        uses([
          proof(
            goal(patient(p004)),
            by(fact("clinical-trial-screening.eye", clause(7)))
          ),
          proof(
            goal(not(inclusion_hba1c(p004))),
            by(builtin(not, 1))
          )
        ])
      )
    ])
  )
).

reason(p001, "meets inclusion criteria and no listed exclusion").
why(
  reason(p001, "meets inclusion criteria and no listed exclusion"),
  proof(
    goal(reason(p001, "meets inclusion criteria and no listed exclusion")),
    by(rule("clinical-trial-screening.eye", clause(36))),
    bindings([binding("?patient", p001)]),
    uses([
      proof(
        goal(screen_eligible(p001)),
        by(rule("clinical-trial-screening.eye", clause(30))),
        bindings([binding("?patient", p001)]),
        uses([
          proof(
            goal(inclusion_adult(p001)),
            by(rule("clinical-trial-screening.eye", clause(25))),
            bindings([binding("?patient", p001), binding("?age", 54)]),
            uses([
              proof(
                goal(patient(p001)),
                by(fact("clinical-trial-screening.eye", clause(4)))
              ),
              proof(
                goal(age(p001, 54)),
                by(fact("clinical-trial-screening.eye", clause(8)))
              ),
              proof(
                goal(ge(54, 18)),
                by(builtin(ge, 2))
              )
            ])
          ),
          proof(
            goal(inclusion_diagnosis(p001)),
            by(rule("clinical-trial-screening.eye", clause(26))),
            bindings([binding("?patient", p001)]),
            uses([
              proof(
                goal(diagnosis(p001, type2_diabetes)),
                by(fact("clinical-trial-screening.eye", clause(12)))
              )
            ])
          ),
          proof(
            goal(inclusion_hba1c(p001)),
            by(rule("clinical-trial-screening.eye", clause(27))),
            bindings([binding("?patient", p001), binding("?hba1c", 8.4)]),
            uses([
              proof(
                goal(lab(p001, hba1c_pct, 8.4)),
                by(fact("clinical-trial-screening.eye", clause(16)))
              ),
              proof(
                goal(ge(8.4, 7.0)),
                by(builtin(ge, 2))
              ),
              proof(
                goal(le(8.4, 10.5)),
                by(builtin(le, 2))
              )
            ])
          ),
          proof(
            goal(not(exclusion_renal(p001))),
            by(builtin(not, 1))
          ),
          proof(
            goal(not(exclusion_pregnancy(p001))),
            by(builtin(not, 1))
          )
        ])
      )
    ])
  )
).

reason(p002, "eGFR below renal safety threshold").
why(
  reason(p002, "eGFR below renal safety threshold"),
  proof(
    goal(reason(p002, "eGFR below renal safety threshold")),
    by(rule("clinical-trial-screening.eye", clause(38))),
    bindings([binding("?patient", p002)]),
    uses([
      proof(
        goal(exclusion_renal(p002)),
        by(rule("clinical-trial-screening.eye", clause(28))),
        bindings([binding("?patient", p002), binding("?egfr", 38.0)]),
        uses([
          proof(
            goal(lab(p002, egfr_ml_min, 38.0)),
            by(fact("clinical-trial-screening.eye", clause(21)))
          ),
          proof(
            goal(lt(38.0, 45.0)),
            by(builtin(lt, 2))
          )
        ])
      )
    ])
  )
).

reason(p003, "pregnancy exclusion applies").
why(
  reason(p003, "pregnancy exclusion applies"),
  proof(
    goal(reason(p003, "pregnancy exclusion applies")),
    by(rule("clinical-trial-screening.eye", clause(39))),
    bindings([binding("?patient", p003)]),
    uses([
      proof(
        goal(exclusion_pregnancy(p003)),
        by(rule("clinical-trial-screening.eye", clause(29))),
        bindings([binding("?patient", p003)]),
        uses([
          proof(
            goal(condition(p003, pregnant)),
            by(fact("clinical-trial-screening.eye", clause(24)))
          )
        ])
      )
    ])
  )
).

reason(p004, "HbA1c is outside protocol range").
why(
  reason(p004, "HbA1c is outside protocol range"),
  proof(
    goal(reason(p004, "HbA1c is outside protocol range")),
    by(rule("clinical-trial-screening.eye", clause(40))),
    bindings([binding("?patient", p004)]),
    uses([
      proof(
        goal(patient(p004)),
        by(fact("clinical-trial-screening.eye", clause(7)))
      ),
      proof(
        goal(not(inclusion_hba1c(p004))),
        by(builtin(not, 1))
      )
    ])
  )
).

