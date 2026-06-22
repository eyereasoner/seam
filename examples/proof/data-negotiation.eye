negotiate(agent1, [agent2, data4]).
why(
  negotiate(agent1, [agent2, data4]),
  proof(
    goal(negotiate(agent1, [agent2, data4])),
    by(rule("data-negotiation.eye", clause(11))),
    bindings([binding("?agenta", agent1), binding("?agentb", agent2), binding("?data", data4)]),
    uses([
      proof(
        goal(want_negotiate(agent1, [agent2, data4])),
        by(fact("data-negotiation.eye", clause(4)))
      ),
      proof(
        goal(request_data(agent1, agent2, data4)),
        by(rule("data-negotiation.eye", clause(9))),
        bindings([binding("?agenta", agent1), binding("?agentb", agent2), binding("?data", data4), binding("?datalista", [data1, data2, data3]), binding("?datalistb", [data4, data5, data6])]),
        uses([
          proof(
            goal(hasData(agent1, [data1, data2, data3])),
            by(fact("data-negotiation.eye", clause(2)))
          ),
          proof(
            goal(hasData(agent2, [data4, data5, data6])),
            by(fact("data-negotiation.eye", clause(3)))
          ),
          proof(
            goal(member(data4, [data4, data5, data6])),
            by(builtin(member, 2))
          ),
          proof(
            goal(not_member(data4, [data1, data2, data3])),
            by(builtin(not_member, 2))
          ),
          proof(
            goal(policy(agent1, [request, data4])),
            by(rule("data-negotiation.eye", clause(7))),
            bindings([binding("?data", data4)]),
            uses([
              proof(
                goal(member(data4, [data4, data6])),
                by(builtin(member, 2))
              )
            ])
          )
        ])
      ),
      proof(
        goal(accept_request(agent2, agent1, data4)),
        by(rule("data-negotiation.eye", clause(10))),
        bindings([binding("?agentb", agent2), binding("?_agenta", agent1), binding("?data", data4), binding("?datalistb", [data4, data5, data6])]),
        uses([
          proof(
            goal(hasData(agent2, [data4, data5, data6])),
            by(fact("data-negotiation.eye", clause(3)))
          ),
          proof(
            goal(member(data4, [data4, data5, data6])),
            by(builtin(member, 2))
          ),
          proof(
            goal(policy(agent2, [accept, data4])),
            by(rule("data-negotiation.eye", clause(8))),
            bindings([binding("?data", data4)]),
            uses([
              proof(
                goal(neq(data4, data5)),
                by(builtin(neq, 2))
              )
            ])
          )
        ])
      )
    ])
  )
).

