evidenceTotal(case, 0.0016436300000000003).
why(
  evidenceTotal(case, 0.0016436300000000003),
  proof(
    goal(evidenceTotal(case, 0.0016436300000000003)),
    by(rule("bayes-diagnosis.eye", clause(52))),
    bindings([binding("?total", 0.0016436300000000003)]),
    uses([
      proof(
        goal(total_score_decimal(0.0016436300000000003)),
        by(fact("bayes-diagnosis.eye", clause(46)))
      )
    ])
  )
).

result(case, result(covid19)).
why(
  result(case, result(covid19)),
  proof(
    goal(result(case, result(covid19))),
    by(rule("bayes-diagnosis.eye", clause(53))),
    bindings([binding("?disease", covid19)]),
    uses([
      proof(
        goal(disease(covid19)),
        by(fact("bayes-diagnosis.eye", clause(7)))
      )
    ])
  )
).

result(case, result(influenza)).
why(
  result(case, result(influenza)),
  proof(
    goal(result(case, result(influenza))),
    by(rule("bayes-diagnosis.eye", clause(53))),
    bindings([binding("?disease", influenza)]),
    uses([
      proof(
        goal(disease(influenza)),
        by(fact("bayes-diagnosis.eye", clause(8)))
      )
    ])
  )
).

result(case, result(allergicRhinitis)).
why(
  result(case, result(allergicRhinitis)),
  proof(
    goal(result(case, result(allergicRhinitis))),
    by(rule("bayes-diagnosis.eye", clause(53))),
    bindings([binding("?disease", allergicRhinitis)]),
    uses([
      proof(
        goal(disease(allergicRhinitis)),
        by(fact("bayes-diagnosis.eye", clause(9)))
      )
    ])
  )
).

result(case, result(bacterialPneumonia)).
why(
  result(case, result(bacterialPneumonia)),
  proof(
    goal(result(case, result(bacterialPneumonia))),
    by(rule("bayes-diagnosis.eye", clause(53))),
    bindings([binding("?disease", bacterialPneumonia)]),
    uses([
      proof(
        goal(disease(bacterialPneumonia)),
        by(fact("bayes-diagnosis.eye", clause(10)))
      )
    ])
  )
).

disease(result(covid19), covid19).
why(
  disease(result(covid19), covid19),
  proof(
    goal(disease(result(covid19), covid19)),
    by(rule("bayes-diagnosis.eye", clause(54))),
    bindings([binding("?disease", covid19)]),
    uses([
      proof(
        goal(disease(covid19)),
        by(fact("bayes-diagnosis.eye", clause(7)))
      )
    ])
  )
).

disease(result(influenza), influenza).
why(
  disease(result(influenza), influenza),
  proof(
    goal(disease(result(influenza), influenza)),
    by(rule("bayes-diagnosis.eye", clause(54))),
    bindings([binding("?disease", influenza)]),
    uses([
      proof(
        goal(disease(influenza)),
        by(fact("bayes-diagnosis.eye", clause(8)))
      )
    ])
  )
).

disease(result(allergicRhinitis), allergicRhinitis).
why(
  disease(result(allergicRhinitis), allergicRhinitis),
  proof(
    goal(disease(result(allergicRhinitis), allergicRhinitis)),
    by(rule("bayes-diagnosis.eye", clause(54))),
    bindings([binding("?disease", allergicRhinitis)]),
    uses([
      proof(
        goal(disease(allergicRhinitis)),
        by(fact("bayes-diagnosis.eye", clause(9)))
      )
    ])
  )
).

disease(result(bacterialPneumonia), bacterialPneumonia).
why(
  disease(result(bacterialPneumonia), bacterialPneumonia),
  proof(
    goal(disease(result(bacterialPneumonia), bacterialPneumonia)),
    by(rule("bayes-diagnosis.eye", clause(54))),
    bindings([binding("?disease", bacterialPneumonia)]),
    uses([
      proof(
        goal(disease(bacterialPneumonia)),
        by(fact("bayes-diagnosis.eye", clause(10)))
      )
    ])
  )
).

unnormalized(result(covid19), 0.0015470000000000002).
why(
  unnormalized(result(covid19), 0.0015470000000000002),
  proof(
    goal(unnormalized(result(covid19), 0.0015470000000000002)),
    by(rule("bayes-diagnosis.eye", clause(55))),
    bindings([binding("?disease", covid19), binding("?score", 0.0015470000000000002)]),
    uses([
      proof(
        goal(score_decimal(covid19, 0.0015470000000000002)),
        by(fact("bayes-diagnosis.eye", clause(42)))
      )
    ])
  )
).

unnormalized(result(influenza), 0.000048000000000000015).
why(
  unnormalized(result(influenza), 0.000048000000000000015),
  proof(
    goal(unnormalized(result(influenza), 0.000048000000000000015)),
    by(rule("bayes-diagnosis.eye", clause(55))),
    bindings([binding("?disease", influenza), binding("?score", 0.000048000000000000015)]),
    uses([
      proof(
        goal(score_decimal(influenza, 0.000048000000000000015)),
        by(fact("bayes-diagnosis.eye", clause(43)))
      )
    ])
  )
).

unnormalized(result(allergicRhinitis), 7.499999999999999e-7).
why(
  unnormalized(result(allergicRhinitis), 7.499999999999999e-7),
  proof(
    goal(unnormalized(result(allergicRhinitis), 7.499999999999999e-7)),
    by(rule("bayes-diagnosis.eye", clause(55))),
    bindings([binding("?disease", allergicRhinitis), binding("?score", 7.499999999999999e-7)]),
    uses([
      proof(
        goal(score_decimal(allergicRhinitis, 7.499999999999999e-7)),
        by(fact("bayes-diagnosis.eye", clause(44)))
      )
    ])
  )
).

unnormalized(result(bacterialPneumonia), 0.000047879999999999996).
why(
  unnormalized(result(bacterialPneumonia), 0.000047879999999999996),
  proof(
    goal(unnormalized(result(bacterialPneumonia), 0.000047879999999999996)),
    by(rule("bayes-diagnosis.eye", clause(55))),
    bindings([binding("?disease", bacterialPneumonia), binding("?score", 0.000047879999999999996)]),
    uses([
      proof(
        goal(score_decimal(bacterialPneumonia, 0.000047879999999999996)),
        by(fact("bayes-diagnosis.eye", clause(45)))
      )
    ])
  )
).

