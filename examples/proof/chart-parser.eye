chart_parser_answer(parsed, command).
why(
  chart_parser_answer(parsed, command),
  proof(
    goal(chart_parser_answer(parsed, command)),
    by(rule("chart-parser.eye", clause(33))),
    bindings([binding("?sentence", command), binding("?length", 5)]),
    uses([
      proof(
        goal(sentence(command, 5)),
        by(fact("chart-parser.eye", clause(3)))
      ),
      proof(
        goal(span(command, s, 0, 5)),
        by(rule("chart-parser.eye", clause(32))),
        bindings([binding("?sentence", command), binding("?category", s), binding("?start", 0), binding("?end", 5), binding("?left", np), binding("?right", vp), binding("?middle", 2)]),
        uses([
          proof(
            goal(rule(s, np, vp)),
            by(fact("chart-parser.eye", clause(25)))
          ),
          proof(
            goal(span(command, np, 0, 2)),
            by(rule("chart-parser.eye", clause(32))),
            bindings([binding("?sentence", command), binding("?category", np), binding("?start", 0), binding("?end", 2), binding("?left", det), binding("?right", noun), binding("?middle", 1)]),
            uses([
              proof(
                goal(rule(np, det, noun)),
                by(fact("chart-parser.eye", clause(26)))
              ),
              proof(
                goal(span(command, det, 0, 1)),
                by(rule("chart-parser.eye", clause(31))),
                bindings([binding("?sentence", command), binding("?category", det), binding("?start", 0), binding("?end", 1), binding("?token", the)]),
                uses([
                  proof(
                    goal(word(command, 0, the)),
                    by(fact("chart-parser.eye", clause(5)))
                  ),
                  proof(
                    goal(terminal(det, the)),
                    by(fact("chart-parser.eye", clause(18)))
                  ),
                  proof(
                    goal(add(0, 1, 1)),
                    by(builtin(add, 3))
                  )
                ])
              ),
              proof(
                goal(span(command, noun, 1, 2)),
                by(rule("chart-parser.eye", clause(31))),
                bindings([binding("?sentence", command), binding("?category", noun), binding("?start", 1), binding("?end", 2), binding("?token", robot)]),
                uses([
                  proof(
                    goal(word(command, 1, robot)),
                    by(fact("chart-parser.eye", clause(6)))
                  ),
                  proof(
                    goal(terminal(noun, robot)),
                    by(fact("chart-parser.eye", clause(19)))
                  ),
                  proof(
                    goal(add(1, 1, 2)),
                    by(builtin(add, 3))
                  )
                ])
              )
            ])
          ),
          proof(
            goal(span(command, vp, 2, 5)),
            by(rule("chart-parser.eye", clause(32))),
            bindings([binding("?sentence", command), binding("?category", vp), binding("?start", 2), binding("?end", 5), binding("?left", verb), binding("?right", np), binding("?middle", 3)]),
            uses([
              proof(
                goal(rule(vp, verb, np)),
                by(fact("chart-parser.eye", clause(28)))
              ),
              proof(
                goal(span(command, verb, 2, 3)),
                by(rule("chart-parser.eye", clause(31))),
                bindings([binding("?sentence", command), binding("?category", verb), binding("?start", 2), binding("?end", 3), binding("?token", moves)]),
                uses([
                  proof(
                    goal(word(command, 2, moves)),
                    by(fact("chart-parser.eye", clause(7)))
                  ),
                  proof(
                    goal(terminal(verb, moves)),
                    by(fact("chart-parser.eye", clause(22)))
                  ),
                  proof(
                    goal(add(2, 1, 3)),
                    by(builtin(add, 3))
                  )
                ])
              ),
              proof(
                goal(span(command, np, 3, 5)),
                by(rule("chart-parser.eye", clause(32))),
                bindings([binding("?sentence", command), binding("?category", np), binding("?start", 3), binding("?end", 5), binding("?left", det), binding("?right", noun), binding("?middle", 4)]),
                uses([
                  proof(
                    goal(rule(np, det, noun)),
                    by(fact("chart-parser.eye", clause(26)))
                  ),
                  proof(
                    goal(span(command, det, 3, 4)),
                    by(rule("chart-parser.eye", clause(31))),
                    bindings([binding("?sentence", command), binding("?category", det), binding("?start", 3), binding("?end", 4), binding("?token", the)]),
                    uses([
                      proof(
                        goal(word(command, 3, the)),
                        by(fact("chart-parser.eye", clause(8)))
                      ),
                      proof(
                        goal(terminal(det, the)),
                        by(fact("chart-parser.eye", clause(18)))
                      ),
                      proof(
                        goal(add(3, 1, 4)),
                        by(builtin(add, 3))
                      )
                    ])
                  ),
                  proof(
                    goal(span(command, noun, 4, 5)),
                    by(rule("chart-parser.eye", clause(31))),
                    bindings([binding("?sentence", command), binding("?category", noun), binding("?start", 4), binding("?end", 5), binding("?token", box)]),
                    uses([
                      proof(
                        goal(word(command, 4, box)),
                        by(fact("chart-parser.eye", clause(9)))
                      ),
                      proof(
                        goal(terminal(noun, box)),
                        by(fact("chart-parser.eye", clause(20)))
                      ),
                      proof(
                        goal(add(4, 1, 5)),
                        by(builtin(add, 3))
                      )
                    ])
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

chart_parser_answer(parsed, ambiguous_pp).
why(
  chart_parser_answer(parsed, ambiguous_pp),
  proof(
    goal(chart_parser_answer(parsed, ambiguous_pp)),
    by(rule("chart-parser.eye", clause(33))),
    bindings([binding("?sentence", ambiguous_pp), binding("?length", 8)]),
    uses([
      proof(
        goal(sentence(ambiguous_pp, 8)),
        by(fact("chart-parser.eye", clause(4)))
      ),
      proof(
        goal(span(ambiguous_pp, s, 0, 8)),
        by(rule("chart-parser.eye", clause(32))),
        bindings([binding("?sentence", ambiguous_pp), binding("?category", s), binding("?start", 0), binding("?end", 8), binding("?left", np), binding("?right", vp), binding("?middle", 2)]),
        uses([
          proof(
            goal(rule(s, np, vp)),
            by(fact("chart-parser.eye", clause(25)))
          ),
          proof(
            goal(span(ambiguous_pp, np, 0, 2)),
            by(rule("chart-parser.eye", clause(32))),
            bindings([binding("?sentence", ambiguous_pp), binding("?category", np), binding("?start", 0), binding("?end", 2), binding("?left", det), binding("?right", noun), binding("?middle", 1)]),
            uses([
              proof(
                goal(rule(np, det, noun)),
                by(fact("chart-parser.eye", clause(26)))
              ),
              proof(
                goal(span(ambiguous_pp, det, 0, 1)),
                by(rule("chart-parser.eye", clause(31))),
                bindings([binding("?sentence", ambiguous_pp), binding("?category", det), binding("?start", 0), binding("?end", 1), binding("?token", the)]),
                uses([
                  proof(
                    goal(word(ambiguous_pp, 0, the)),
                    by(fact("chart-parser.eye", clause(10)))
                  ),
                  proof(
                    goal(terminal(det, the)),
                    by(fact("chart-parser.eye", clause(18)))
                  ),
                  proof(
                    goal(add(0, 1, 1)),
                    by(builtin(add, 3))
                  )
                ])
              ),
              proof(
                goal(span(ambiguous_pp, noun, 1, 2)),
                by(rule("chart-parser.eye", clause(31))),
                bindings([binding("?sentence", ambiguous_pp), binding("?category", noun), binding("?start", 1), binding("?end", 2), binding("?token", robot)]),
                uses([
                  proof(
                    goal(word(ambiguous_pp, 1, robot)),
                    by(fact("chart-parser.eye", clause(11)))
                  ),
                  proof(
                    goal(terminal(noun, robot)),
                    by(fact("chart-parser.eye", clause(19)))
                  ),
                  proof(
                    goal(add(1, 1, 2)),
                    by(builtin(add, 3))
                  )
                ])
              )
            ])
          ),
          proof(
            goal(span(ambiguous_pp, vp, 2, 8)),
            by(rule("chart-parser.eye", clause(32))),
            bindings([binding("?sentence", ambiguous_pp), binding("?category", vp), binding("?start", 2), binding("?end", 8), binding("?left", verb), binding("?right", np), binding("?middle", 3)]),
            uses([
              proof(
                goal(rule(vp, verb, np)),
                by(fact("chart-parser.eye", clause(28)))
              ),
              proof(
                goal(span(ambiguous_pp, verb, 2, 3)),
                by(rule("chart-parser.eye", clause(31))),
                bindings([binding("?sentence", ambiguous_pp), binding("?category", verb), binding("?start", 2), binding("?end", 3), binding("?token", sees)]),
                uses([
                  proof(
                    goal(word(ambiguous_pp, 2, sees)),
                    by(fact("chart-parser.eye", clause(12)))
                  ),
                  proof(
                    goal(terminal(verb, sees)),
                    by(fact("chart-parser.eye", clause(23)))
                  ),
                  proof(
                    goal(add(2, 1, 3)),
                    by(builtin(add, 3))
                  )
                ])
              ),
              proof(
                goal(span(ambiguous_pp, np, 3, 8)),
                by(rule("chart-parser.eye", clause(32))),
                bindings([binding("?sentence", ambiguous_pp), binding("?category", np), binding("?start", 3), binding("?end", 8), binding("?left", np), binding("?right", pp), binding("?middle", 5)]),
                uses([
                  proof(
                    goal(rule(np, np, pp)),
                    by(fact("chart-parser.eye", clause(27)))
                  ),
                  proof(
                    goal(span(ambiguous_pp, np, 3, 5)),
                    by(rule("chart-parser.eye", clause(32))),
                    bindings([binding("?sentence", ambiguous_pp), binding("?category", np), binding("?start", 3), binding("?end", 5), binding("?left", det), binding("?right", noun), binding("?middle", 4)]),
                    uses([
                      proof(
                        goal(rule(np, det, noun)),
                        by(fact("chart-parser.eye", clause(26)))
                      ),
                      proof(
                        goal(span(ambiguous_pp, det, 3, 4)),
                        by(rule("chart-parser.eye", clause(31))),
                        bindings([binding("?sentence", ambiguous_pp), binding("?category", det), binding("?start", 3), binding("?end", 4), binding("?token", the)]),
                        uses([
                          proof(
                            goal(word(ambiguous_pp, 3, the)),
                            by(fact("chart-parser.eye", clause(13)))
                          ),
                          proof(
                            goal(terminal(det, the)),
                            by(fact("chart-parser.eye", clause(18)))
                          ),
                          proof(
                            goal(add(3, 1, 4)),
                            by(builtin(add, 3))
                          )
                        ])
                      ),
                      proof(
                        goal(span(ambiguous_pp, noun, 4, 5)),
                        by(rule("chart-parser.eye", clause(31))),
                        bindings([binding("?sentence", ambiguous_pp), binding("?category", noun), binding("?start", 4), binding("?end", 5), binding("?token", box)]),
                        uses([
                          proof(
                            goal(word(ambiguous_pp, 4, box)),
                            by(fact("chart-parser.eye", clause(14)))
                          ),
                          proof(
                            goal(terminal(noun, box)),
                            by(fact("chart-parser.eye", clause(20)))
                          ),
                          proof(
                            goal(add(4, 1, 5)),
                            by(builtin(add, 3))
                          )
                        ])
                      )
                    ])
                  ),
                  proof(
                    goal(span(ambiguous_pp, pp, 5, 8)),
                    by(rule("chart-parser.eye", clause(32))),
                    bindings([binding("?sentence", ambiguous_pp), binding("?category", pp), binding("?start", 5), binding("?end", 8), binding("?left", prep), binding("?right", np), binding("?middle", 6)]),
                    uses([
                      proof(
                        goal(rule(pp, prep, np)),
                        by(fact("chart-parser.eye", clause(30)))
                      ),
                      proof(
                        goal(span(ambiguous_pp, prep, 5, 6)),
                        by(rule("chart-parser.eye", clause(31))),
                        bindings([binding("?sentence", ambiguous_pp), binding("?category", prep), binding("?start", 5), binding("?end", 6), binding("?token", with)]),
                        uses([
                          proof(
                            goal(word(ambiguous_pp, 5, with)),
                            by(fact("chart-parser.eye", clause(15)))
                          ),
                          proof(
                            goal(terminal(prep, with)),
                            by(fact("chart-parser.eye", clause(24)))
                          ),
                          proof(
                            goal(add(5, 1, 6)),
                            by(builtin(add, 3))
                          )
                        ])
                      ),
                      proof(
                        goal(span(ambiguous_pp, np, 6, 8)),
                        by(rule("chart-parser.eye", clause(32))),
                        bindings([binding("?sentence", ambiguous_pp), binding("?category", np), binding("?start", 6), binding("?end", 8), binding("?left", det), binding("?right", noun), binding("?middle", 7)]),
                        uses([
                          proof(
                            goal(rule(np, det, noun)),
                            by(fact("chart-parser.eye", clause(26)))
                          ),
                          proof(
                            goal(span(ambiguous_pp, det, 6, 7)),
                            by(rule("chart-parser.eye", clause(31))),
                            bindings([binding("?sentence", ambiguous_pp), binding("?category", det), binding("?start", 6), binding("?end", 7), binding("?token", the)]),
                            uses([
                              proof(
                                goal(word(ambiguous_pp, 6, the)),
                                by(fact("chart-parser.eye", clause(16)))
                              ),
                              proof(
                                goal(terminal(det, the)),
                                by(fact("chart-parser.eye", clause(18)))
                              ),
                              proof(
                                goal(add(6, 1, 7)),
                                by(builtin(add, 3))
                              )
                            ])
                          ),
                          proof(
                            goal(span(ambiguous_pp, noun, 7, 8)),
                            by(rule("chart-parser.eye", clause(31))),
                            bindings([binding("?sentence", ambiguous_pp), binding("?category", noun), binding("?start", 7), binding("?end", 8), binding("?token", telescope)]),
                            uses([
                              proof(
                                goal(word(ambiguous_pp, 7, telescope)),
                                by(fact("chart-parser.eye", clause(17)))
                              ),
                              proof(
                                goal(terminal(noun, telescope)),
                                by(fact("chart-parser.eye", clause(21)))
                              ),
                              proof(
                                goal(add(7, 1, 8)),
                                by(builtin(add, 3))
                              )
                            ])
                          )
                        ])
                      )
                    ])
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

chart_parser_answer(parse_count, count(command, 1)).
why(
  chart_parser_answer(parse_count, count(command, 1)),
  proof(
    goal(chart_parser_answer(parse_count, count(command, 1))),
    by(rule("chart-parser.eye", clause(34))),
    bindings([binding("?sentence", command), binding("?count", 1), binding("?length", 5)]),
    uses([
      proof(
        goal(sentence(command, 5)),
        by(fact("chart-parser.eye", clause(3)))
      ),
      proof(
        goal(countall(span(command, s, 0, 5), 1)),
        by(builtin(countall, 2))
      )
    ])
  )
).

chart_parser_answer(parse_count, count(ambiguous_pp, 1)).
why(
  chart_parser_answer(parse_count, count(ambiguous_pp, 1)),
  no_proof
).

chart_parser_answer(noun_phrase_count, count(command, 2)).
why(
  chart_parser_answer(noun_phrase_count, count(command, 2)),
  proof(
    goal(chart_parser_answer(noun_phrase_count, count(command, 2))),
    by(rule("chart-parser.eye", clause(35))),
    bindings([binding("?sentence", command), binding("?count", 2), binding("?length", 5)]),
    uses([
      proof(
        goal(sentence(command, 5)),
        by(fact("chart-parser.eye", clause(3)))
      ),
      proof(
        goal(countall(span(command, np, ?_start, ?_end), 2)),
        by(builtin(countall, 2))
      ),
      proof(
        goal(gt(5, 0)),
        by(builtin(gt, 2))
      )
    ])
  )
).

chart_parser_answer(noun_phrase_count, count(ambiguous_pp, 3)).
why(
  chart_parser_answer(noun_phrase_count, count(ambiguous_pp, 3)),
  proof(
    goal(chart_parser_answer(noun_phrase_count, count(ambiguous_pp, 3))),
    by(rule("chart-parser.eye", clause(35))),
    bindings([binding("?sentence", ambiguous_pp), binding("?count", 3), binding("?length", 8)]),
    uses([
      proof(
        goal(sentence(ambiguous_pp, 8)),
        by(fact("chart-parser.eye", clause(4)))
      ),
      proof(
        goal(countall(span(ambiguous_pp, np, ?_start, ?_end), 3)),
        by(builtin(countall, 2))
      ),
      proof(
        goal(gt(8, 0)),
        by(builtin(gt, 2))
      )
    ])
  )
).

