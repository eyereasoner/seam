errorRate(canary42, 0.014999999999999999).
why(
  errorRate(canary42, 0.014999999999999999),
  proof(
    goal(errorRate(canary42, 0.014999999999999999)),
    by(rule("canary-release.eye", clause(13))),
    bindings([binding("?release", canary42), binding("?rate", 0.014999999999999999)]),
    uses([
      proof(
        goal(error_rate(canary42, 0.014999999999999999)),
        by(rule("canary-release.eye", clause(9))),
        bindings([binding("?release", canary42), binding("?rate", 0.014999999999999999), binding("?requests", 5000.0), binding("?errors", 75.0), binding("?_p95latency", 180.0)]),
        uses([
          proof(
            goal(canary(canary42, 5000.0, 75.0, 180.0)),
            by(fact("canary-release.eye", clause(6)))
          ),
          proof(
            goal(div(75.0, 5000.0, 0.014999999999999999)),
            by(builtin(div, 3))
          )
        ])
      )
    ])
  )
).

p95Latency_ms(canary42, 180.0).
why(
  p95Latency_ms(canary42, 180.0),
  proof(
    goal(p95Latency_ms(canary42, 180.0)),
    by(rule("canary-release.eye", clause(14))),
    bindings([binding("?release", canary42), binding("?p95latency", 180.0), binding("?_requests", 5000.0), binding("?_errors", 75.0)]),
    uses([
      proof(
        goal(canary(canary42, 5000.0, 75.0, 180.0)),
        by(fact("canary-release.eye", clause(6)))
      )
    ])
  )
).

latencyCheck(canary42, ok).
why(
  latencyCheck(canary42, ok),
  proof(
    goal(latencyCheck(canary42, ok)),
    by(rule("canary-release.eye", clause(15))),
    bindings([binding("?release", canary42)]),
    uses([
      proof(
        goal(latency_ok(canary42)),
        by(rule("canary-release.eye", clause(10))),
        bindings([binding("?release", canary42), binding("?_requests", 5000.0), binding("?_errors", 75.0), binding("?p95latency", 180.0), binding("?maximum", 200.0)]),
        uses([
          proof(
            goal(canary(canary42, 5000.0, 75.0, 180.0)),
            by(fact("canary-release.eye", clause(6)))
          ),
          proof(
            goal(threshold(canary42, maximum_p95_latency_ms, 200.0)),
            by(fact("canary-release.eye", clause(8)))
          ),
          proof(
            goal(lt(180.0, 200.0)),
            by(builtin(lt, 2))
          )
        ])
      )
    ])
  )
).

status(canary42, rollback_recommended).
why(
  status(canary42, rollback_recommended),
  proof(
    goal(status(canary42, rollback_recommended)),
    by(rule("canary-release.eye", clause(16))),
    bindings([binding("?release", canary42)]),
    uses([
      proof(
        goal(rollback_recommended(canary42)),
        by(rule("canary-release.eye", clause(12))),
        bindings([binding("?release", canary42)]),
        uses([
          proof(
            goal(error_budget_exceeded(canary42)),
            by(rule("canary-release.eye", clause(11))),
            bindings([binding("?release", canary42), binding("?rate", 0.014999999999999999), binding("?maximum", 0.01)]),
            uses([
              proof(
                goal(error_rate(canary42, 0.014999999999999999)),
                by(rule("canary-release.eye", clause(9))),
                bindings([binding("?release", canary42), binding("?rate", 0.014999999999999999), binding("?requests", 5000.0), binding("?errors", 75.0), binding("?_p95latency", 180.0)]),
                uses([
                  proof(
                    goal(canary(canary42, 5000.0, 75.0, 180.0)),
                    by(fact("canary-release.eye", clause(6)))
                  ),
                  proof(
                    goal(div(75.0, 5000.0, 0.014999999999999999)),
                    by(builtin(div, 3))
                  )
                ])
              ),
              proof(
                goal(threshold(canary42, maximum_error_rate, 0.01)),
                by(fact("canary-release.eye", clause(7)))
              ),
              proof(
                goal(gt(0.014999999999999999, 0.01)),
                by(builtin(gt, 2))
              )
            ])
          )
        ])
      )
    ])
  )
).

reason(canary42, "canary error rate exceeds the allowed budget").
why(
  reason(canary42, "canary error rate exceeds the allowed budget"),
  proof(
    goal(reason(canary42, "canary error rate exceeds the allowed budget")),
    by(rule("canary-release.eye", clause(17))),
    bindings([binding("?release", canary42)]),
    uses([
      proof(
        goal(rollback_recommended(canary42)),
        by(rule("canary-release.eye", clause(12))),
        bindings([binding("?release", canary42)]),
        uses([
          proof(
            goal(error_budget_exceeded(canary42)),
            by(rule("canary-release.eye", clause(11))),
            bindings([binding("?release", canary42), binding("?rate", 0.014999999999999999), binding("?maximum", 0.01)]),
            uses([
              proof(
                goal(error_rate(canary42, 0.014999999999999999)),
                by(rule("canary-release.eye", clause(9))),
                bindings([binding("?release", canary42), binding("?rate", 0.014999999999999999), binding("?requests", 5000.0), binding("?errors", 75.0), binding("?_p95latency", 180.0)]),
                uses([
                  proof(
                    goal(canary(canary42, 5000.0, 75.0, 180.0)),
                    by(fact("canary-release.eye", clause(6)))
                  ),
                  proof(
                    goal(div(75.0, 5000.0, 0.014999999999999999)),
                    by(builtin(div, 3))
                  )
                ])
              ),
              proof(
                goal(threshold(canary42, maximum_error_rate, 0.01)),
                by(fact("canary-release.eye", clause(7)))
              ),
              proof(
                goal(gt(0.014999999999999999, 0.01)),
                by(builtin(gt, 2))
              )
            ])
          )
        ])
      )
    ])
  )
).

