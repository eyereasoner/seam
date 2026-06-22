% Reference 9: standard built-ins compose into a reusable data-processing workflow.
materialize(answer, 2).
row(" alice : 3,5,7 ").
row(" bob : 2,4 ").
field(?name, ?scores) :- row(?raw), trim(?raw, ?t), split(?t, ":", [?nameraw, ?scoresraw]), trim(?nameraw, ?nametext), atom_string(?name, ?nametext), trim(?scoresraw, ?cleanscores), split(?cleanscores, ",", ?scoretexts), scores(?scoretexts, ?scores).
scores([], []).
scores([?text | ?resttext], [?n | ?rest]) :- number_string(?n, ?text), scores(?resttext, ?rest).
answer(total(?name), ?total) :- field(?name, ?scores), sum_list(?scores, ?total).
answer(maximum(?name), ?max) :- field(?name, ?scores), max_list(?scores, ?max).
answer(report(?name), ?text) :- field(?name, ?scores), length(?scores, ?count), number_string(?count, ?counttext), atom_string(?name, ?nametext), str_concat(?nametext, ":", ?prefix), str_concat(?prefix, ?counttext, ?text).
