status(no_mandate, insufficient_control).
why(
  status(no_mandate, insufficient_control),
  proof(
    goal(status(no_mandate, insufficient_control)),
    by(rule("epidemic-policy.eye", clause(25))),
    bindings([binding("?p", no_mandate), binding("?r", 1.3999999999999999)]),
    uses([
      proof(
        goal(policy(no_mandate)),
        by(fact("epidemic-policy.eye", clause(6)))
      ),
      proof(
        goal(risk_score(no_mandate, 1.3999999999999999)),
        by(rule("epidemic-policy.eye", clause(23))),
        bindings([binding("?p", no_mandate), binding("?r", 1.3999999999999999), binding("?base", 1.40), binding("?vf", 1.00), binding("?mf", 1.00), binding("?a", 1.3999999999999999)]),
        uses([
          proof(
            goal(base_risk(1.40)),
            by(fact("epidemic-policy.eye", clause(10)))
          ),
          proof(
            goal(vaccination_factor(no_mandate, 1.00)),
            by(fact("epidemic-policy.eye", clause(11)))
          ),
          proof(
            goal(mask_factor(no_mandate, 1.00)),
            by(fact("epidemic-policy.eye", clause(15)))
          ),
          proof(
            goal(mul(1.40, 1.00, 1.3999999999999999)),
            by(builtin(mul, 3))
          ),
          proof(
            goal(mul(1.3999999999999999, 1.00, 1.3999999999999999)),
            by(builtin(mul, 3))
          )
        ])
      ),
      proof(
        goal(gt(1.3999999999999999, 0.75)),
        by(builtin(gt, 2))
      )
    ])
  )
).

status(vaccination_campaign, insufficient_control).
why(
  status(vaccination_campaign, insufficient_control),
  proof(
    goal(status(vaccination_campaign, insufficient_control)),
    by(rule("epidemic-policy.eye", clause(25))),
    bindings([binding("?p", vaccination_campaign), binding("?r", 0.77000000000000002)]),
    uses([
      proof(
        goal(policy(vaccination_campaign)),
        by(fact("epidemic-policy.eye", clause(7)))
      ),
      proof(
        goal(risk_score(vaccination_campaign, 0.77000000000000002)),
        by(rule("epidemic-policy.eye", clause(23))),
        bindings([binding("?p", vaccination_campaign), binding("?r", 0.77000000000000002), binding("?base", 1.40), binding("?vf", 0.55), binding("?mf", 1.00), binding("?a", 0.77000000000000002)]),
        uses([
          proof(
            goal(base_risk(1.40)),
            by(fact("epidemic-policy.eye", clause(10)))
          ),
          proof(
            goal(vaccination_factor(vaccination_campaign, 0.55)),
            by(fact("epidemic-policy.eye", clause(12)))
          ),
          proof(
            goal(mask_factor(vaccination_campaign, 1.00)),
            by(fact("epidemic-policy.eye", clause(16)))
          ),
          proof(
            goal(mul(1.40, 0.55, 0.77000000000000002)),
            by(builtin(mul, 3))
          ),
          proof(
            goal(mul(0.77000000000000002, 1.00, 0.77000000000000002)),
            by(builtin(mul, 3))
          )
        ])
      ),
      proof(
        goal(gt(0.77000000000000002, 0.75)),
        by(builtin(gt, 2))
      )
    ])
  )
).

status(indoor_masks, insufficient_control).
why(
  status(indoor_masks, insufficient_control),
  proof(
    goal(status(indoor_masks, insufficient_control)),
    by(rule("epidemic-policy.eye", clause(25))),
    bindings([binding("?p", indoor_masks), binding("?r", 0.90999999999999992)]),
    uses([
      proof(
        goal(policy(indoor_masks)),
        by(fact("epidemic-policy.eye", clause(8)))
      ),
      proof(
        goal(risk_score(indoor_masks, 0.90999999999999992)),
        by(rule("epidemic-policy.eye", clause(23))),
        bindings([binding("?p", indoor_masks), binding("?r", 0.90999999999999992), binding("?base", 1.40), binding("?vf", 1.00), binding("?mf", 0.65), binding("?a", 1.3999999999999999)]),
        uses([
          proof(
            goal(base_risk(1.40)),
            by(fact("epidemic-policy.eye", clause(10)))
          ),
          proof(
            goal(vaccination_factor(indoor_masks, 1.00)),
            by(fact("epidemic-policy.eye", clause(13)))
          ),
          proof(
            goal(mask_factor(indoor_masks, 0.65)),
            by(fact("epidemic-policy.eye", clause(17)))
          ),
          proof(
            goal(mul(1.40, 1.00, 1.3999999999999999)),
            by(builtin(mul, 3))
          ),
          proof(
            goal(mul(1.3999999999999999, 0.65, 0.90999999999999992)),
            by(builtin(mul, 3))
          )
        ])
      ),
      proof(
        goal(gt(0.90999999999999992, 0.75)),
        by(builtin(gt, 2))
      )
    ])
  )
).

status(vaccination_and_masks, acceptable_control).
why(
  status(vaccination_and_masks, acceptable_control),
  proof(
    goal(status(vaccination_and_masks, acceptable_control)),
    by(rule("epidemic-policy.eye", clause(26))),
    bindings([binding("?p", vaccination_and_masks)]),
    uses([
      proof(
        goal(acceptable(vaccination_and_masks)),
        by(rule("epidemic-policy.eye", clause(24))),
        bindings([binding("?p", vaccination_and_masks), binding("?r", 0.50050000000000006)]),
        uses([
          proof(
            goal(risk_score(vaccination_and_masks, 0.50050000000000006)),
            by(rule("epidemic-policy.eye", clause(23))),
            bindings([binding("?p", vaccination_and_masks), binding("?r", 0.50050000000000006), binding("?base", 1.40), binding("?vf", 0.55), binding("?mf", 0.65), binding("?a", 0.77000000000000002)]),
            uses([
              proof(
                goal(base_risk(1.40)),
                by(fact("epidemic-policy.eye", clause(10)))
              ),
              proof(
                goal(vaccination_factor(vaccination_and_masks, 0.55)),
                by(fact("epidemic-policy.eye", clause(14)))
              ),
              proof(
                goal(mask_factor(vaccination_and_masks, 0.65)),
                by(fact("epidemic-policy.eye", clause(18)))
              ),
              proof(
                goal(mul(1.40, 0.55, 0.77000000000000002)),
                by(builtin(mul, 3))
              ),
              proof(
                goal(mul(0.77000000000000002, 0.65, 0.50050000000000006)),
                by(builtin(mul, 3))
              )
            ])
          ),
          proof(
            goal(le(0.50050000000000006, 0.75)),
            by(builtin(le, 2))
          )
        ])
      )
    ])
  )
).

riskScore(no_mandate, 1.3999999999999999).
why(
  riskScore(no_mandate, 1.3999999999999999),
  proof(
    goal(riskScore(no_mandate, 1.3999999999999999)),
    by(rule("epidemic-policy.eye", clause(28))),
    bindings([binding("?p", no_mandate), binding("?r", 1.3999999999999999)]),
    uses([
      proof(
        goal(risk_score(no_mandate, 1.3999999999999999)),
        by(rule("epidemic-policy.eye", clause(23))),
        bindings([binding("?p", no_mandate), binding("?r", 1.3999999999999999), binding("?base", 1.40), binding("?vf", 1.00), binding("?mf", 1.00), binding("?a", 1.3999999999999999)]),
        uses([
          proof(
            goal(base_risk(1.40)),
            by(fact("epidemic-policy.eye", clause(10)))
          ),
          proof(
            goal(vaccination_factor(no_mandate, 1.00)),
            by(fact("epidemic-policy.eye", clause(11)))
          ),
          proof(
            goal(mask_factor(no_mandate, 1.00)),
            by(fact("epidemic-policy.eye", clause(15)))
          ),
          proof(
            goal(mul(1.40, 1.00, 1.3999999999999999)),
            by(builtin(mul, 3))
          ),
          proof(
            goal(mul(1.3999999999999999, 1.00, 1.3999999999999999)),
            by(builtin(mul, 3))
          )
        ])
      )
    ])
  )
).

riskScore(vaccination_campaign, 0.77000000000000002).
why(
  riskScore(vaccination_campaign, 0.77000000000000002),
  proof(
    goal(riskScore(vaccination_campaign, 0.77000000000000002)),
    by(rule("epidemic-policy.eye", clause(28))),
    bindings([binding("?p", vaccination_campaign), binding("?r", 0.77000000000000002)]),
    uses([
      proof(
        goal(risk_score(vaccination_campaign, 0.77000000000000002)),
        by(rule("epidemic-policy.eye", clause(23))),
        bindings([binding("?p", vaccination_campaign), binding("?r", 0.77000000000000002), binding("?base", 1.40), binding("?vf", 0.55), binding("?mf", 1.00), binding("?a", 0.77000000000000002)]),
        uses([
          proof(
            goal(base_risk(1.40)),
            by(fact("epidemic-policy.eye", clause(10)))
          ),
          proof(
            goal(vaccination_factor(vaccination_campaign, 0.55)),
            by(fact("epidemic-policy.eye", clause(12)))
          ),
          proof(
            goal(mask_factor(vaccination_campaign, 1.00)),
            by(fact("epidemic-policy.eye", clause(16)))
          ),
          proof(
            goal(mul(1.40, 0.55, 0.77000000000000002)),
            by(builtin(mul, 3))
          ),
          proof(
            goal(mul(0.77000000000000002, 1.00, 0.77000000000000002)),
            by(builtin(mul, 3))
          )
        ])
      )
    ])
  )
).

riskScore(indoor_masks, 0.90999999999999992).
why(
  riskScore(indoor_masks, 0.90999999999999992),
  proof(
    goal(riskScore(indoor_masks, 0.90999999999999992)),
    by(rule("epidemic-policy.eye", clause(28))),
    bindings([binding("?p", indoor_masks), binding("?r", 0.90999999999999992)]),
    uses([
      proof(
        goal(risk_score(indoor_masks, 0.90999999999999992)),
        by(rule("epidemic-policy.eye", clause(23))),
        bindings([binding("?p", indoor_masks), binding("?r", 0.90999999999999992), binding("?base", 1.40), binding("?vf", 1.00), binding("?mf", 0.65), binding("?a", 1.3999999999999999)]),
        uses([
          proof(
            goal(base_risk(1.40)),
            by(fact("epidemic-policy.eye", clause(10)))
          ),
          proof(
            goal(vaccination_factor(indoor_masks, 1.00)),
            by(fact("epidemic-policy.eye", clause(13)))
          ),
          proof(
            goal(mask_factor(indoor_masks, 0.65)),
            by(fact("epidemic-policy.eye", clause(17)))
          ),
          proof(
            goal(mul(1.40, 1.00, 1.3999999999999999)),
            by(builtin(mul, 3))
          ),
          proof(
            goal(mul(1.3999999999999999, 0.65, 0.90999999999999992)),
            by(builtin(mul, 3))
          )
        ])
      )
    ])
  )
).

riskScore(vaccination_and_masks, 0.50050000000000006).
why(
  riskScore(vaccination_and_masks, 0.50050000000000006),
  proof(
    goal(riskScore(vaccination_and_masks, 0.50050000000000006)),
    by(rule("epidemic-policy.eye", clause(28))),
    bindings([binding("?p", vaccination_and_masks), binding("?r", 0.50050000000000006)]),
    uses([
      proof(
        goal(risk_score(vaccination_and_masks, 0.50050000000000006)),
        by(rule("epidemic-policy.eye", clause(23))),
        bindings([binding("?p", vaccination_and_masks), binding("?r", 0.50050000000000006), binding("?base", 1.40), binding("?vf", 0.55), binding("?mf", 0.65), binding("?a", 0.77000000000000002)]),
        uses([
          proof(
            goal(base_risk(1.40)),
            by(fact("epidemic-policy.eye", clause(10)))
          ),
          proof(
            goal(vaccination_factor(vaccination_and_masks, 0.55)),
            by(fact("epidemic-policy.eye", clause(14)))
          ),
          proof(
            goal(mask_factor(vaccination_and_masks, 0.65)),
            by(fact("epidemic-policy.eye", clause(18)))
          ),
          proof(
            goal(mul(1.40, 0.55, 0.77000000000000002)),
            by(builtin(mul, 3))
          ),
          proof(
            goal(mul(0.77000000000000002, 0.65, 0.50050000000000006)),
            by(builtin(mul, 3))
          )
        ])
      )
    ])
  )
).

cost(no_mandate, 0).
why(
  cost(no_mandate, 0),
  proof(
    goal(cost(no_mandate, 0)),
    by(rule("epidemic-policy.eye", clause(29))),
    bindings([binding("?p", no_mandate), binding("?c", 0)]),
    uses([
      proof(
        goal(policy_cost(no_mandate, 0)),
        by(fact("epidemic-policy.eye", clause(19)))
      )
    ])
  )
).

cost(vaccination_campaign, 3).
why(
  cost(vaccination_campaign, 3),
  proof(
    goal(cost(vaccination_campaign, 3)),
    by(rule("epidemic-policy.eye", clause(29))),
    bindings([binding("?p", vaccination_campaign), binding("?c", 3)]),
    uses([
      proof(
        goal(policy_cost(vaccination_campaign, 3)),
        by(fact("epidemic-policy.eye", clause(20)))
      )
    ])
  )
).

cost(indoor_masks, 2).
why(
  cost(indoor_masks, 2),
  proof(
    goal(cost(indoor_masks, 2)),
    by(rule("epidemic-policy.eye", clause(29))),
    bindings([binding("?p", indoor_masks), binding("?c", 2)]),
    uses([
      proof(
        goal(policy_cost(indoor_masks, 2)),
        by(fact("epidemic-policy.eye", clause(21)))
      )
    ])
  )
).

cost(vaccination_and_masks, 5).
why(
  cost(vaccination_and_masks, 5),
  proof(
    goal(cost(vaccination_and_masks, 5)),
    by(rule("epidemic-policy.eye", clause(29))),
    bindings([binding("?p", vaccination_and_masks), binding("?c", 5)]),
    uses([
      proof(
        goal(policy_cost(vaccination_and_masks, 5)),
        by(fact("epidemic-policy.eye", clause(22)))
      )
    ])
  )
).

recommendedPolicy(epidemic_policy, vaccination_and_masks).
why(
  recommendedPolicy(epidemic_policy, vaccination_and_masks),
  proof(
    goal(recommendedPolicy(epidemic_policy, vaccination_and_masks)),
    by(rule("epidemic-policy.eye", clause(30))),
    bindings([binding("?p", vaccination_and_masks)]),
    uses([
      proof(
        goal(recommended(vaccination_and_masks)),
        by(rule("epidemic-policy.eye", clause(27))),
        uses([
          proof(
            goal(acceptable(vaccination_and_masks)),
            by(rule("epidemic-policy.eye", clause(24))),
            bindings([binding("?p", vaccination_and_masks), binding("?r", 0.50050000000000006)]),
            uses([
              proof(
                goal(risk_score(vaccination_and_masks, 0.50050000000000006)),
                by(rule("epidemic-policy.eye", clause(23))),
                bindings([binding("?p", vaccination_and_masks), binding("?r", 0.50050000000000006), binding("?base", 1.40), binding("?vf", 0.55), binding("?mf", 0.65), binding("?a", 0.77000000000000002)]),
                uses([
                  proof(
                    goal(base_risk(1.40)),
                    by(fact("epidemic-policy.eye", clause(10)))
                  ),
                  proof(
                    goal(vaccination_factor(vaccination_and_masks, 0.55)),
                    by(fact("epidemic-policy.eye", clause(14)))
                  ),
                  proof(
                    goal(mask_factor(vaccination_and_masks, 0.65)),
                    by(fact("epidemic-policy.eye", clause(18)))
                  ),
                  proof(
                    goal(mul(1.40, 0.55, 0.77000000000000002)),
                    by(builtin(mul, 3))
                  ),
                  proof(
                    goal(mul(0.77000000000000002, 0.65, 0.50050000000000006)),
                    by(builtin(mul, 3))
                  )
                ])
              ),
              proof(
                goal(le(0.50050000000000006, 0.75)),
                by(builtin(le, 2))
              )
            ])
          ),
          proof(
            goal(status(no_mandate, insufficient_control)),
            by(rule("epidemic-policy.eye", clause(25))),
            bindings([binding("?p", no_mandate), binding("?r", 1.3999999999999999)]),
            uses([
              proof(
                goal(policy(no_mandate)),
                by(fact("epidemic-policy.eye", clause(6)))
              ),
              proof(
                goal(risk_score(no_mandate, 1.3999999999999999)),
                by(rule("epidemic-policy.eye", clause(23))),
                bindings([binding("?p", no_mandate), binding("?r", 1.3999999999999999), binding("?base", 1.40), binding("?vf", 1.00), binding("?mf", 1.00), binding("?a", 1.3999999999999999)]),
                uses([
                  proof(
                    goal(base_risk(1.40)),
                    by(fact("epidemic-policy.eye", clause(10)))
                  ),
                  proof(
                    goal(vaccination_factor(no_mandate, 1.00)),
                    by(fact("epidemic-policy.eye", clause(11)))
                  ),
                  proof(
                    goal(mask_factor(no_mandate, 1.00)),
                    by(fact("epidemic-policy.eye", clause(15)))
                  ),
                  proof(
                    goal(mul(1.40, 1.00, 1.3999999999999999)),
                    by(builtin(mul, 3))
                  ),
                  proof(
                    goal(mul(1.3999999999999999, 1.00, 1.3999999999999999)),
                    by(builtin(mul, 3))
                  )
                ])
              ),
              proof(
                goal(gt(1.3999999999999999, 0.75)),
                by(builtin(gt, 2))
              )
            ])
          ),
          proof(
            goal(status(vaccination_campaign, insufficient_control)),
            by(rule("epidemic-policy.eye", clause(25))),
            bindings([binding("?p", vaccination_campaign), binding("?r", 0.77000000000000002)]),
            uses([
              proof(
                goal(policy(vaccination_campaign)),
                by(fact("epidemic-policy.eye", clause(7)))
              ),
              proof(
                goal(risk_score(vaccination_campaign, 0.77000000000000002)),
                by(rule("epidemic-policy.eye", clause(23))),
                bindings([binding("?p", vaccination_campaign), binding("?r", 0.77000000000000002), binding("?base", 1.40), binding("?vf", 0.55), binding("?mf", 1.00), binding("?a", 0.77000000000000002)]),
                uses([
                  proof(
                    goal(base_risk(1.40)),
                    by(fact("epidemic-policy.eye", clause(10)))
                  ),
                  proof(
                    goal(vaccination_factor(vaccination_campaign, 0.55)),
                    by(fact("epidemic-policy.eye", clause(12)))
                  ),
                  proof(
                    goal(mask_factor(vaccination_campaign, 1.00)),
                    by(fact("epidemic-policy.eye", clause(16)))
                  ),
                  proof(
                    goal(mul(1.40, 0.55, 0.77000000000000002)),
                    by(builtin(mul, 3))
                  ),
                  proof(
                    goal(mul(0.77000000000000002, 1.00, 0.77000000000000002)),
                    by(builtin(mul, 3))
                  )
                ])
              ),
              proof(
                goal(gt(0.77000000000000002, 0.75)),
                by(builtin(gt, 2))
              )
            ])
          ),
          proof(
            goal(status(indoor_masks, insufficient_control)),
            by(rule("epidemic-policy.eye", clause(25))),
            bindings([binding("?p", indoor_masks), binding("?r", 0.90999999999999992)]),
            uses([
              proof(
                goal(policy(indoor_masks)),
                by(fact("epidemic-policy.eye", clause(8)))
              ),
              proof(
                goal(risk_score(indoor_masks, 0.90999999999999992)),
                by(rule("epidemic-policy.eye", clause(23))),
                bindings([binding("?p", indoor_masks), binding("?r", 0.90999999999999992), binding("?base", 1.40), binding("?vf", 1.00), binding("?mf", 0.65), binding("?a", 1.3999999999999999)]),
                uses([
                  proof(
                    goal(base_risk(1.40)),
                    by(fact("epidemic-policy.eye", clause(10)))
                  ),
                  proof(
                    goal(vaccination_factor(indoor_masks, 1.00)),
                    by(fact("epidemic-policy.eye", clause(13)))
                  ),
                  proof(
                    goal(mask_factor(indoor_masks, 0.65)),
                    by(fact("epidemic-policy.eye", clause(17)))
                  ),
                  proof(
                    goal(mul(1.40, 1.00, 1.3999999999999999)),
                    by(builtin(mul, 3))
                  ),
                  proof(
                    goal(mul(1.3999999999999999, 0.65, 0.90999999999999992)),
                    by(builtin(mul, 3))
                  )
                ])
              ),
              proof(
                goal(gt(0.90999999999999992, 0.75)),
                by(builtin(gt, 2))
              )
            ])
          )
        ])
      )
    ])
  )
).

reason(epidemic_policy, "combined vaccination and indoor masks are the only policy below the outbreak threshold").
why(
  reason(epidemic_policy, "combined vaccination and indoor masks are the only policy below the outbreak threshold"),
  proof(
    goal(reason(epidemic_policy, "combined vaccination and indoor masks are the only policy below the outbreak threshold")),
    by(rule("epidemic-policy.eye", clause(31))),
    uses([
      proof(
        goal(recommended(vaccination_and_masks)),
        by(rule("epidemic-policy.eye", clause(27))),
        uses([
          proof(
            goal(acceptable(vaccination_and_masks)),
            by(rule("epidemic-policy.eye", clause(24))),
            bindings([binding("?p", vaccination_and_masks), binding("?r", 0.50050000000000006)]),
            uses([
              proof(
                goal(risk_score(vaccination_and_masks, 0.50050000000000006)),
                by(rule("epidemic-policy.eye", clause(23))),
                bindings([binding("?p", vaccination_and_masks), binding("?r", 0.50050000000000006), binding("?base", 1.40), binding("?vf", 0.55), binding("?mf", 0.65), binding("?a", 0.77000000000000002)]),
                uses([
                  proof(
                    goal(base_risk(1.40)),
                    by(fact("epidemic-policy.eye", clause(10)))
                  ),
                  proof(
                    goal(vaccination_factor(vaccination_and_masks, 0.55)),
                    by(fact("epidemic-policy.eye", clause(14)))
                  ),
                  proof(
                    goal(mask_factor(vaccination_and_masks, 0.65)),
                    by(fact("epidemic-policy.eye", clause(18)))
                  ),
                  proof(
                    goal(mul(1.40, 0.55, 0.77000000000000002)),
                    by(builtin(mul, 3))
                  ),
                  proof(
                    goal(mul(0.77000000000000002, 0.65, 0.50050000000000006)),
                    by(builtin(mul, 3))
                  )
                ])
              ),
              proof(
                goal(le(0.50050000000000006, 0.75)),
                by(builtin(le, 2))
              )
            ])
          ),
          proof(
            goal(status(no_mandate, insufficient_control)),
            by(rule("epidemic-policy.eye", clause(25))),
            bindings([binding("?p", no_mandate), binding("?r", 1.3999999999999999)]),
            uses([
              proof(
                goal(policy(no_mandate)),
                by(fact("epidemic-policy.eye", clause(6)))
              ),
              proof(
                goal(risk_score(no_mandate, 1.3999999999999999)),
                by(rule("epidemic-policy.eye", clause(23))),
                bindings([binding("?p", no_mandate), binding("?r", 1.3999999999999999), binding("?base", 1.40), binding("?vf", 1.00), binding("?mf", 1.00), binding("?a", 1.3999999999999999)]),
                uses([
                  proof(
                    goal(base_risk(1.40)),
                    by(fact("epidemic-policy.eye", clause(10)))
                  ),
                  proof(
                    goal(vaccination_factor(no_mandate, 1.00)),
                    by(fact("epidemic-policy.eye", clause(11)))
                  ),
                  proof(
                    goal(mask_factor(no_mandate, 1.00)),
                    by(fact("epidemic-policy.eye", clause(15)))
                  ),
                  proof(
                    goal(mul(1.40, 1.00, 1.3999999999999999)),
                    by(builtin(mul, 3))
                  ),
                  proof(
                    goal(mul(1.3999999999999999, 1.00, 1.3999999999999999)),
                    by(builtin(mul, 3))
                  )
                ])
              ),
              proof(
                goal(gt(1.3999999999999999, 0.75)),
                by(builtin(gt, 2))
              )
            ])
          ),
          proof(
            goal(status(vaccination_campaign, insufficient_control)),
            by(rule("epidemic-policy.eye", clause(25))),
            bindings([binding("?p", vaccination_campaign), binding("?r", 0.77000000000000002)]),
            uses([
              proof(
                goal(policy(vaccination_campaign)),
                by(fact("epidemic-policy.eye", clause(7)))
              ),
              proof(
                goal(risk_score(vaccination_campaign, 0.77000000000000002)),
                by(rule("epidemic-policy.eye", clause(23))),
                bindings([binding("?p", vaccination_campaign), binding("?r", 0.77000000000000002), binding("?base", 1.40), binding("?vf", 0.55), binding("?mf", 1.00), binding("?a", 0.77000000000000002)]),
                uses([
                  proof(
                    goal(base_risk(1.40)),
                    by(fact("epidemic-policy.eye", clause(10)))
                  ),
                  proof(
                    goal(vaccination_factor(vaccination_campaign, 0.55)),
                    by(fact("epidemic-policy.eye", clause(12)))
                  ),
                  proof(
                    goal(mask_factor(vaccination_campaign, 1.00)),
                    by(fact("epidemic-policy.eye", clause(16)))
                  ),
                  proof(
                    goal(mul(1.40, 0.55, 0.77000000000000002)),
                    by(builtin(mul, 3))
                  ),
                  proof(
                    goal(mul(0.77000000000000002, 1.00, 0.77000000000000002)),
                    by(builtin(mul, 3))
                  )
                ])
              ),
              proof(
                goal(gt(0.77000000000000002, 0.75)),
                by(builtin(gt, 2))
              )
            ])
          ),
          proof(
            goal(status(indoor_masks, insufficient_control)),
            by(rule("epidemic-policy.eye", clause(25))),
            bindings([binding("?p", indoor_masks), binding("?r", 0.90999999999999992)]),
            uses([
              proof(
                goal(policy(indoor_masks)),
                by(fact("epidemic-policy.eye", clause(8)))
              ),
              proof(
                goal(risk_score(indoor_masks, 0.90999999999999992)),
                by(rule("epidemic-policy.eye", clause(23))),
                bindings([binding("?p", indoor_masks), binding("?r", 0.90999999999999992), binding("?base", 1.40), binding("?vf", 1.00), binding("?mf", 0.65), binding("?a", 1.3999999999999999)]),
                uses([
                  proof(
                    goal(base_risk(1.40)),
                    by(fact("epidemic-policy.eye", clause(10)))
                  ),
                  proof(
                    goal(vaccination_factor(indoor_masks, 1.00)),
                    by(fact("epidemic-policy.eye", clause(13)))
                  ),
                  proof(
                    goal(mask_factor(indoor_masks, 0.65)),
                    by(fact("epidemic-policy.eye", clause(17)))
                  ),
                  proof(
                    goal(mul(1.40, 1.00, 1.3999999999999999)),
                    by(builtin(mul, 3))
                  ),
                  proof(
                    goal(mul(1.3999999999999999, 0.65, 0.90999999999999992)),
                    by(builtin(mul, 3))
                  )
                ])
              ),
              proof(
                goal(gt(0.90999999999999992, 0.75)),
                by(builtin(gt, 2))
              )
            ])
          )
        ])
      )
    ])
  )
).

