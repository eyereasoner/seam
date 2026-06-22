% Reference 9.1: reusable built-ins compose without special host predicates.
materialize(answer, 2).
line("  red,green,blue  ").
answer(clean_join, ?x) :- line(?raw), trim(?raw, ?trimmed), split(?trimmed, ",", ?parts), join(?parts, "|", ?x).
answer(middle_upper, ?x) :- line(?raw), trim(?raw, ?trimmed), split(?trimmed, ",", ?parts), nth0(1, ?parts, ?middle), uppercase(?middle, ?x).
answer(summary, result(?head, ?last, ?count)) :- line(?raw), trim(?raw, ?t), split(?t, ",", ?parts), head(?parts, ?head), last(?parts, ?last), length(?parts, ?count).
answer(term_report, ?x) :- compound_name_arguments(?term, measurement, [temperature, 21]), term_string(?term, ?x).
answer(score_text, ?x) :- max_list([3, 9, 5], ?max), number_string(?max, ?text), str_concat("max=", ?text, ?x).
