status(test1, policy_passed).
why(
  status(test1, policy_passed),
  proof(
    goal(status(test1, policy_passed)),
    by(rule("access-control-policy.eye", clause(18))),
    uses([
      proof(
        goal(passes_policy(test1, policy_x)),
        by(rule("access-control-policy.eye", clause(16))),
        bindings([binding("?request", test1), binding("?policy", policy_x)]),
        uses([
          proof(
            goal(passes_all_of(test1, policy_x)),
            by(rule("access-control-policy.eye", clause(13))),
            bindings([binding("?request", test1), binding("?policy", policy_x)]),
            uses([
              proof(
                goal(policy_request(test1, policy_x)),
                by(fact("access-control-policy.eye", clause(4)))
              ),
              proof(
                goal(policy(policy_x)),
                by(fact("access-control-policy.eye", clause(8)))
              ),
              proof(
                goal(not((allOf(policy_x, ?claim), not(has(test1, ?claim))))),
                by(builtin(not, 1))
              )
            ])
          ),
          proof(
            goal(passes_any_of(test1, policy_x)),
            by(rule("access-control-policy.eye", clause(14))),
            bindings([binding("?request", test1), binding("?policy", policy_x), binding("?claim", claim_c)]),
            uses([
              proof(
                goal(policy_request(test1, policy_x)),
                by(fact("access-control-policy.eye", clause(4)))
              ),
              proof(
                goal(policy(policy_x)),
                by(fact("access-control-policy.eye", clause(8)))
              ),
              proof(
                goal(anyOf(policy_x, claim_c)),
                by(fact("access-control-policy.eye", clause(11)))
              ),
              proof(
                goal(has(test1, claim_c)),
                by(fact("access-control-policy.eye", clause(7)))
              )
            ])
          ),
          proof(
            goal(passes_none_of(test1, policy_x)),
            by(rule("access-control-policy.eye", clause(15))),
            bindings([binding("?request", test1), binding("?policy", policy_x)]),
            uses([
              proof(
                goal(policy_request(test1, policy_x)),
                by(fact("access-control-policy.eye", clause(4)))
              ),
              proof(
                goal(policy(policy_x)),
                by(fact("access-control-policy.eye", clause(8)))
              ),
              proof(
                goal(not((noneOf(policy_x, ?claim), has(test1, ?claim)))),
                by(builtin(not, 1))
              )
            ])
          )
        ])
      )
    ])
  )
).

reason(test1, "all required claims are present, one allowed claim is present, and no forbidden claim is present").
why(
  reason(test1, "all required claims are present, one allowed claim is present, and no forbidden claim is present"),
  proof(
    goal(reason(test1, "all required claims are present, one allowed claim is present, and no forbidden claim is present")),
    by(rule("access-control-policy.eye", clause(19))),
    uses([
      proof(
        goal(passes_policy(test1, policy_x)),
        by(rule("access-control-policy.eye", clause(16))),
        bindings([binding("?request", test1), binding("?policy", policy_x)]),
        uses([
          proof(
            goal(passes_all_of(test1, policy_x)),
            by(rule("access-control-policy.eye", clause(13))),
            bindings([binding("?request", test1), binding("?policy", policy_x)]),
            uses([
              proof(
                goal(policy_request(test1, policy_x)),
                by(fact("access-control-policy.eye", clause(4)))
              ),
              proof(
                goal(policy(policy_x)),
                by(fact("access-control-policy.eye", clause(8)))
              ),
              proof(
                goal(not((allOf(policy_x, ?claim), not(has(test1, ?claim))))),
                by(builtin(not, 1))
              )
            ])
          ),
          proof(
            goal(passes_any_of(test1, policy_x)),
            by(rule("access-control-policy.eye", clause(14))),
            bindings([binding("?request", test1), binding("?policy", policy_x), binding("?claim", claim_c)]),
            uses([
              proof(
                goal(policy_request(test1, policy_x)),
                by(fact("access-control-policy.eye", clause(4)))
              ),
              proof(
                goal(policy(policy_x)),
                by(fact("access-control-policy.eye", clause(8)))
              ),
              proof(
                goal(anyOf(policy_x, claim_c)),
                by(fact("access-control-policy.eye", clause(11)))
              ),
              proof(
                goal(has(test1, claim_c)),
                by(fact("access-control-policy.eye", clause(7)))
              )
            ])
          ),
          proof(
            goal(passes_none_of(test1, policy_x)),
            by(rule("access-control-policy.eye", clause(15))),
            bindings([binding("?request", test1), binding("?policy", policy_x)]),
            uses([
              proof(
                goal(policy_request(test1, policy_x)),
                by(fact("access-control-policy.eye", clause(4)))
              ),
              proof(
                goal(policy(policy_x)),
                by(fact("access-control-policy.eye", clause(8)))
              ),
              proof(
                goal(not((noneOf(policy_x, ?claim), has(test1, ?claim)))),
                by(builtin(not, 1))
              )
            ])
          )
        ])
      )
    ])
  )
).

