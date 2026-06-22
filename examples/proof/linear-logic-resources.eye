linear_result(kitchen, [mill, mix, bake], [bread]).
why(
  linear_result(kitchen, [mill, mix, bake], [bread]),
  proof(
    goal(linear_result(kitchen, [mill, mix, bake], [bread])),
    by(rule("linear-logic-resources.eye", clause(15))),
    bindings([binding("?plan", [mill, mix, bake]), binding("?finalstate", [bread]), binding("?state", [wheat, yeast, heat])]),
    uses([
      proof(
        goal(initial(kitchen, [wheat, yeast, heat])),
        by(fact("linear-logic-resources.eye", clause(3)))
      ),
      proof(
        goal(run_linear(3, [wheat, yeast, heat], [mill, mix, bake], [bread])),
        by(rule("linear-logic-resources.eye", clause(14))),
        bindings([binding("?steps", 3), binding("?state0", [wheat, yeast, heat]), binding("?rule", mill), binding("?plan", [mix, bake]), binding("?state2", [bread]), binding("?state1", [flour, yeast, heat]), binding("?remaining", 2)]),
        uses([
          proof(
            goal(gt(3, 0)),
            by(builtin(gt, 2))
          ),
          proof(
            goal(linear_step([wheat, yeast, heat], mill, [flour, yeast, heat])),
            by(rule("linear-logic-resources.eye", clause(12))),
            bindings([binding("?state0", [wheat, yeast, heat]), binding("?rule", mill), binding("?state2", [flour, yeast, heat]), binding("?inputs", [wheat]), binding("?outputs", [flour]), binding("?rest", [yeast, heat])]),
            uses([
              proof(
                goal(linear_rule(mill, [wheat], [flour])),
                by(fact("linear-logic-resources.eye", clause(5)))
              ),
              proof(
                goal(consume_all([wheat], [wheat, yeast, heat], [yeast, heat])),
                by(rule("linear-logic-resources.eye", clause(11))),
                bindings([binding("?need", wheat), binding("?needs", []), binding("?state0", [wheat, yeast, heat]), binding("?state2", [yeast, heat]), binding("?state1", [yeast, heat])]),
                uses([
                  proof(
                    goal(select(wheat, [wheat, yeast, heat], [yeast, heat])),
                    by(builtin(select, 3))
                  ),
                  proof(
                    goal(consume_all([], [yeast, heat], [yeast, heat])),
                    by(fact("linear-logic-resources.eye", clause(10))),
                    bindings([binding("?state", [yeast, heat])])
                  )
                ])
              ),
              proof(
                goal(append([flour], [yeast, heat], [flour, yeast, heat])),
                by(builtin(append, 3))
              )
            ])
          ),
          proof(
            goal(sub(3, 1, 2)),
            by(builtin(sub, 3))
          ),
          proof(
            goal(run_linear(2, [flour, yeast, heat], [mix, bake], [bread])),
            by(rule("linear-logic-resources.eye", clause(14))),
            bindings([binding("?steps", 2), binding("?state0", [flour, yeast, heat]), binding("?rule", mix), binding("?plan", [bake]), binding("?state2", [bread]), binding("?state1", [dough, heat]), binding("?remaining", 1)]),
            uses([
              proof(
                goal(gt(2, 0)),
                by(builtin(gt, 2))
              ),
              proof(
                goal(linear_step([flour, yeast, heat], mix, [dough, heat])),
                by(rule("linear-logic-resources.eye", clause(12))),
                bindings([binding("?state0", [flour, yeast, heat]), binding("?rule", mix), binding("?state2", [dough, heat]), binding("?inputs", [flour, yeast]), binding("?outputs", [dough]), binding("?rest", [heat])]),
                uses([
                  proof(
                    goal(linear_rule(mix, [flour, yeast], [dough])),
                    by(fact("linear-logic-resources.eye", clause(6)))
                  ),
                  proof(
                    goal(consume_all([flour, yeast], [flour, yeast, heat], [heat])),
                    by(rule("linear-logic-resources.eye", clause(11))),
                    bindings([binding("?need", flour), binding("?needs", [yeast]), binding("?state0", [flour, yeast, heat]), binding("?state2", [heat]), binding("?state1", [yeast, heat])]),
                    uses([
                      proof(
                        goal(select(flour, [flour, yeast, heat], [yeast, heat])),
                        by(builtin(select, 3))
                      ),
                      proof(
                        goal(consume_all([yeast], [yeast, heat], [heat])),
                        by(rule("linear-logic-resources.eye", clause(11))),
                        bindings([binding("?need", yeast), binding("?needs", []), binding("?state0", [yeast, heat]), binding("?state2", [heat]), binding("?state1", [heat])]),
                        uses([
                          proof(
                            goal(select(yeast, [yeast, heat], [heat])),
                            by(builtin(select, 3))
                          ),
                          proof(
                            goal(consume_all([], [heat], [heat])),
                            by(fact("linear-logic-resources.eye", clause(10))),
                            bindings([binding("?state", [heat])])
                          )
                        ])
                      )
                    ])
                  ),
                  proof(
                    goal(append([dough], [heat], [dough, heat])),
                    by(builtin(append, 3))
                  )
                ])
              ),
              proof(
                goal(sub(2, 1, 1)),
                by(builtin(sub, 3))
              ),
              proof(
                goal(run_linear(1, [dough, heat], [bake], [bread])),
                by(rule("linear-logic-resources.eye", clause(14))),
                bindings([binding("?steps", 1), binding("?state0", [dough, heat]), binding("?rule", bake), binding("?plan", []), binding("?state2", [bread]), binding("?state1", [bread]), binding("?remaining", 0)]),
                uses([
                  proof(
                    goal(gt(1, 0)),
                    by(builtin(gt, 2))
                  ),
                  proof(
                    goal(linear_step([dough, heat], bake, [bread])),
                    by(rule("linear-logic-resources.eye", clause(12))),
                    bindings([binding("?state0", [dough, heat]), binding("?rule", bake), binding("?state2", [bread]), binding("?inputs", [dough, heat]), binding("?outputs", [bread]), binding("?rest", [])]),
                    uses([
                      proof(
                        goal(linear_rule(bake, [dough, heat], [bread])),
                        by(fact("linear-logic-resources.eye", clause(7)))
                      ),
                      proof(
                        goal(consume_all([dough, heat], [dough, heat], [])),
                        by(rule("linear-logic-resources.eye", clause(11))),
                        bindings([binding("?need", dough), binding("?needs", [heat]), binding("?state0", [dough, heat]), binding("?state2", []), binding("?state1", [heat])]),
                        uses([
                          proof(
                            goal(select(dough, [dough, heat], [heat])),
                            by(builtin(select, 3))
                          ),
                          proof(
                            goal(consume_all([heat], [heat], [])),
                            by(rule("linear-logic-resources.eye", clause(11))),
                            bindings([binding("?need", heat), binding("?needs", []), binding("?state0", [heat]), binding("?state2", []), binding("?state1", [])]),
                            uses([
                              proof(
                                goal(select(heat, [heat], [])),
                                by(builtin(select, 3))
                              ),
                              proof(
                                goal(consume_all([], [], [])),
                                by(fact("linear-logic-resources.eye", clause(10))),
                                bindings([binding("?state", [])])
                              )
                            ])
                          )
                        ])
                      ),
                      proof(
                        goal(append([bread], [], [bread])),
                        by(builtin(append, 3))
                      )
                    ])
                  ),
                  proof(
                    goal(sub(1, 1, 0)),
                    by(builtin(sub, 3))
                  ),
                  proof(
                    goal(run_linear(0, [bread], [], [bread])),
                    by(fact("linear-logic-resources.eye", clause(13))),
                    bindings([binding("?state", [bread])])
                  )
                ])
              )
            ])
          )
        ])
      ),
      proof(
        goal(eq([bread], [bread])),
        by(builtin(eq, 2))
      )
    ])
  )
).

linear_check(double_spend_rejected, yes).
why(
  linear_check(double_spend_rejected, yes),
  proof(
    goal(linear_check(double_spend_rejected, yes)),
    by(rule("linear-logic-resources.eye", clause(16))),
    bindings([binding("?state", [coin])]),
    uses([
      proof(
        goal(initial(wallet, [coin])),
        by(fact("linear-logic-resources.eye", clause(4)))
      ),
      proof(
        goal(not(run_linear(2, [coin], [buy_flour, buy_yeast], ?_finalstate))),
        by(builtin(not, 1))
      )
    ])
  )
).

