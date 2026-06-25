% =============================================================================================================================
% Deep Taxonomy - depth 100 - expanded N3-style eyelang
%
% Adjacent rules mirror the Eyeling N3 deep-taxonomy chain. Each step derives
% the next taxonomy class together with two side labels.
% =============================================================================================================================

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(is, 2).
materialize(answer, 2).
materialize(reason, 2).
materialize(result, 2).
materialize(checkPassed, 2).
materialize(arc, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
% fact

a(ind, n0).

% terminal rule

% Derivation rules: each rule below contributes one logical step toward the displayed results.
is(test, true) :- once(a(ind, a2)).
a(?x, a2) :- a(?x, n100).

% Adjacent N3-style taxonomy rules.

a(?x, n1) :- a(?x, n0).
a(?x, i1) :- a(?x, n0).
a(?x, j1) :- a(?x, n0).
a(?x, n2) :- a(?x, n1).
a(?x, i2) :- a(?x, n1).
a(?x, j2) :- a(?x, n1).
a(?x, n3) :- a(?x, n2).
a(?x, i3) :- a(?x, n2).
a(?x, j3) :- a(?x, n2).
a(?x, n4) :- a(?x, n3).
a(?x, i4) :- a(?x, n3).
a(?x, j4) :- a(?x, n3).
a(?x, n5) :- a(?x, n4).
a(?x, i5) :- a(?x, n4).
a(?x, j5) :- a(?x, n4).
a(?x, n6) :- a(?x, n5).
a(?x, i6) :- a(?x, n5).
a(?x, j6) :- a(?x, n5).
a(?x, n7) :- a(?x, n6).
a(?x, i7) :- a(?x, n6).
a(?x, j7) :- a(?x, n6).
a(?x, n8) :- a(?x, n7).
a(?x, i8) :- a(?x, n7).
a(?x, j8) :- a(?x, n7).
a(?x, n9) :- a(?x, n8).
a(?x, i9) :- a(?x, n8).
a(?x, j9) :- a(?x, n8).
a(?x, n10) :- a(?x, n9).
a(?x, i10) :- a(?x, n9).
a(?x, j10) :- a(?x, n9).
a(?x, n11) :- a(?x, n10).
a(?x, i11) :- a(?x, n10).
a(?x, j11) :- a(?x, n10).
a(?x, n12) :- a(?x, n11).
a(?x, i12) :- a(?x, n11).
a(?x, j12) :- a(?x, n11).
a(?x, n13) :- a(?x, n12).
a(?x, i13) :- a(?x, n12).
a(?x, j13) :- a(?x, n12).
a(?x, n14) :- a(?x, n13).
a(?x, i14) :- a(?x, n13).
a(?x, j14) :- a(?x, n13).
a(?x, n15) :- a(?x, n14).
a(?x, i15) :- a(?x, n14).
a(?x, j15) :- a(?x, n14).
a(?x, n16) :- a(?x, n15).
a(?x, i16) :- a(?x, n15).
a(?x, j16) :- a(?x, n15).
a(?x, n17) :- a(?x, n16).
a(?x, i17) :- a(?x, n16).
a(?x, j17) :- a(?x, n16).
a(?x, n18) :- a(?x, n17).
a(?x, i18) :- a(?x, n17).
a(?x, j18) :- a(?x, n17).
a(?x, n19) :- a(?x, n18).
a(?x, i19) :- a(?x, n18).
a(?x, j19) :- a(?x, n18).
a(?x, n20) :- a(?x, n19).
a(?x, i20) :- a(?x, n19).
a(?x, j20) :- a(?x, n19).
a(?x, n21) :- a(?x, n20).
a(?x, i21) :- a(?x, n20).
a(?x, j21) :- a(?x, n20).
a(?x, n22) :- a(?x, n21).
a(?x, i22) :- a(?x, n21).
a(?x, j22) :- a(?x, n21).
a(?x, n23) :- a(?x, n22).
a(?x, i23) :- a(?x, n22).
a(?x, j23) :- a(?x, n22).
a(?x, n24) :- a(?x, n23).
a(?x, i24) :- a(?x, n23).
a(?x, j24) :- a(?x, n23).
a(?x, n25) :- a(?x, n24).
a(?x, i25) :- a(?x, n24).
a(?x, j25) :- a(?x, n24).
a(?x, n26) :- a(?x, n25).
a(?x, i26) :- a(?x, n25).
a(?x, j26) :- a(?x, n25).
a(?x, n27) :- a(?x, n26).
a(?x, i27) :- a(?x, n26).
a(?x, j27) :- a(?x, n26).
a(?x, n28) :- a(?x, n27).
a(?x, i28) :- a(?x, n27).
a(?x, j28) :- a(?x, n27).
a(?x, n29) :- a(?x, n28).
a(?x, i29) :- a(?x, n28).
a(?x, j29) :- a(?x, n28).
a(?x, n30) :- a(?x, n29).
a(?x, i30) :- a(?x, n29).
a(?x, j30) :- a(?x, n29).
a(?x, n31) :- a(?x, n30).
a(?x, i31) :- a(?x, n30).
a(?x, j31) :- a(?x, n30).
a(?x, n32) :- a(?x, n31).
a(?x, i32) :- a(?x, n31).
a(?x, j32) :- a(?x, n31).
a(?x, n33) :- a(?x, n32).
a(?x, i33) :- a(?x, n32).
a(?x, j33) :- a(?x, n32).
a(?x, n34) :- a(?x, n33).
a(?x, i34) :- a(?x, n33).
a(?x, j34) :- a(?x, n33).
a(?x, n35) :- a(?x, n34).
a(?x, i35) :- a(?x, n34).
a(?x, j35) :- a(?x, n34).
a(?x, n36) :- a(?x, n35).
a(?x, i36) :- a(?x, n35).
a(?x, j36) :- a(?x, n35).
a(?x, n37) :- a(?x, n36).
a(?x, i37) :- a(?x, n36).
a(?x, j37) :- a(?x, n36).
a(?x, n38) :- a(?x, n37).
a(?x, i38) :- a(?x, n37).
a(?x, j38) :- a(?x, n37).
a(?x, n39) :- a(?x, n38).
a(?x, i39) :- a(?x, n38).
a(?x, j39) :- a(?x, n38).
a(?x, n40) :- a(?x, n39).
a(?x, i40) :- a(?x, n39).
a(?x, j40) :- a(?x, n39).
a(?x, n41) :- a(?x, n40).
a(?x, i41) :- a(?x, n40).
a(?x, j41) :- a(?x, n40).
a(?x, n42) :- a(?x, n41).
a(?x, i42) :- a(?x, n41).
a(?x, j42) :- a(?x, n41).
a(?x, n43) :- a(?x, n42).
a(?x, i43) :- a(?x, n42).
a(?x, j43) :- a(?x, n42).
a(?x, n44) :- a(?x, n43).
a(?x, i44) :- a(?x, n43).
a(?x, j44) :- a(?x, n43).
a(?x, n45) :- a(?x, n44).
a(?x, i45) :- a(?x, n44).
a(?x, j45) :- a(?x, n44).
a(?x, n46) :- a(?x, n45).
a(?x, i46) :- a(?x, n45).
a(?x, j46) :- a(?x, n45).
a(?x, n47) :- a(?x, n46).
a(?x, i47) :- a(?x, n46).
a(?x, j47) :- a(?x, n46).
a(?x, n48) :- a(?x, n47).
a(?x, i48) :- a(?x, n47).
a(?x, j48) :- a(?x, n47).
a(?x, n49) :- a(?x, n48).
a(?x, i49) :- a(?x, n48).
a(?x, j49) :- a(?x, n48).
a(?x, n50) :- a(?x, n49).
a(?x, i50) :- a(?x, n49).
a(?x, j50) :- a(?x, n49).
a(?x, n51) :- a(?x, n50).
a(?x, i51) :- a(?x, n50).
a(?x, j51) :- a(?x, n50).
a(?x, n52) :- a(?x, n51).
a(?x, i52) :- a(?x, n51).
a(?x, j52) :- a(?x, n51).
a(?x, n53) :- a(?x, n52).
a(?x, i53) :- a(?x, n52).
a(?x, j53) :- a(?x, n52).
a(?x, n54) :- a(?x, n53).
a(?x, i54) :- a(?x, n53).
a(?x, j54) :- a(?x, n53).
a(?x, n55) :- a(?x, n54).
a(?x, i55) :- a(?x, n54).
a(?x, j55) :- a(?x, n54).
a(?x, n56) :- a(?x, n55).
a(?x, i56) :- a(?x, n55).
a(?x, j56) :- a(?x, n55).
a(?x, n57) :- a(?x, n56).
a(?x, i57) :- a(?x, n56).
a(?x, j57) :- a(?x, n56).
a(?x, n58) :- a(?x, n57).
a(?x, i58) :- a(?x, n57).
a(?x, j58) :- a(?x, n57).
a(?x, n59) :- a(?x, n58).
a(?x, i59) :- a(?x, n58).
a(?x, j59) :- a(?x, n58).
a(?x, n60) :- a(?x, n59).
a(?x, i60) :- a(?x, n59).
a(?x, j60) :- a(?x, n59).
a(?x, n61) :- a(?x, n60).
a(?x, i61) :- a(?x, n60).
a(?x, j61) :- a(?x, n60).
a(?x, n62) :- a(?x, n61).
a(?x, i62) :- a(?x, n61).
a(?x, j62) :- a(?x, n61).
a(?x, n63) :- a(?x, n62).
a(?x, i63) :- a(?x, n62).
a(?x, j63) :- a(?x, n62).
a(?x, n64) :- a(?x, n63).
a(?x, i64) :- a(?x, n63).
a(?x, j64) :- a(?x, n63).
a(?x, n65) :- a(?x, n64).
a(?x, i65) :- a(?x, n64).
a(?x, j65) :- a(?x, n64).
a(?x, n66) :- a(?x, n65).
a(?x, i66) :- a(?x, n65).
a(?x, j66) :- a(?x, n65).
a(?x, n67) :- a(?x, n66).
a(?x, i67) :- a(?x, n66).
a(?x, j67) :- a(?x, n66).
a(?x, n68) :- a(?x, n67).
a(?x, i68) :- a(?x, n67).
a(?x, j68) :- a(?x, n67).
a(?x, n69) :- a(?x, n68).
a(?x, i69) :- a(?x, n68).
a(?x, j69) :- a(?x, n68).
a(?x, n70) :- a(?x, n69).
a(?x, i70) :- a(?x, n69).
a(?x, j70) :- a(?x, n69).
a(?x, n71) :- a(?x, n70).
a(?x, i71) :- a(?x, n70).
a(?x, j71) :- a(?x, n70).
a(?x, n72) :- a(?x, n71).
a(?x, i72) :- a(?x, n71).
a(?x, j72) :- a(?x, n71).
a(?x, n73) :- a(?x, n72).
a(?x, i73) :- a(?x, n72).
a(?x, j73) :- a(?x, n72).
a(?x, n74) :- a(?x, n73).
a(?x, i74) :- a(?x, n73).
a(?x, j74) :- a(?x, n73).
a(?x, n75) :- a(?x, n74).
a(?x, i75) :- a(?x, n74).
a(?x, j75) :- a(?x, n74).
a(?x, n76) :- a(?x, n75).
a(?x, i76) :- a(?x, n75).
a(?x, j76) :- a(?x, n75).
a(?x, n77) :- a(?x, n76).
a(?x, i77) :- a(?x, n76).
a(?x, j77) :- a(?x, n76).
a(?x, n78) :- a(?x, n77).
a(?x, i78) :- a(?x, n77).
a(?x, j78) :- a(?x, n77).
a(?x, n79) :- a(?x, n78).
a(?x, i79) :- a(?x, n78).
a(?x, j79) :- a(?x, n78).
a(?x, n80) :- a(?x, n79).
a(?x, i80) :- a(?x, n79).
a(?x, j80) :- a(?x, n79).
a(?x, n81) :- a(?x, n80).
a(?x, i81) :- a(?x, n80).
a(?x, j81) :- a(?x, n80).
a(?x, n82) :- a(?x, n81).
a(?x, i82) :- a(?x, n81).
a(?x, j82) :- a(?x, n81).
a(?x, n83) :- a(?x, n82).
a(?x, i83) :- a(?x, n82).
a(?x, j83) :- a(?x, n82).
a(?x, n84) :- a(?x, n83).
a(?x, i84) :- a(?x, n83).
a(?x, j84) :- a(?x, n83).
a(?x, n85) :- a(?x, n84).
a(?x, i85) :- a(?x, n84).
a(?x, j85) :- a(?x, n84).
a(?x, n86) :- a(?x, n85).
a(?x, i86) :- a(?x, n85).
a(?x, j86) :- a(?x, n85).
a(?x, n87) :- a(?x, n86).
a(?x, i87) :- a(?x, n86).
a(?x, j87) :- a(?x, n86).
a(?x, n88) :- a(?x, n87).
a(?x, i88) :- a(?x, n87).
a(?x, j88) :- a(?x, n87).
a(?x, n89) :- a(?x, n88).
a(?x, i89) :- a(?x, n88).
a(?x, j89) :- a(?x, n88).
a(?x, n90) :- a(?x, n89).
a(?x, i90) :- a(?x, n89).
a(?x, j90) :- a(?x, n89).
a(?x, n91) :- a(?x, n90).
a(?x, i91) :- a(?x, n90).
a(?x, j91) :- a(?x, n90).
a(?x, n92) :- a(?x, n91).
a(?x, i92) :- a(?x, n91).
a(?x, j92) :- a(?x, n91).
a(?x, n93) :- a(?x, n92).
a(?x, i93) :- a(?x, n92).
a(?x, j93) :- a(?x, n92).
a(?x, n94) :- a(?x, n93).
a(?x, i94) :- a(?x, n93).
a(?x, j94) :- a(?x, n93).
a(?x, n95) :- a(?x, n94).
a(?x, i95) :- a(?x, n94).
a(?x, j95) :- a(?x, n94).
a(?x, n96) :- a(?x, n95).
a(?x, i96) :- a(?x, n95).
a(?x, j96) :- a(?x, n95).
a(?x, n97) :- a(?x, n96).
a(?x, i97) :- a(?x, n96).
a(?x, j97) :- a(?x, n96).
a(?x, n98) :- a(?x, n97).
a(?x, i98) :- a(?x, n97).
a(?x, j98) :- a(?x, n97).
a(?x, n99) :- a(?x, n98).
a(?x, i99) :- a(?x, n98).
a(?x, j99) :- a(?x, n98).
a(?x, n100) :- a(?x, n99).
a(?x, i100) :- a(?x, n99).
a(?x, j100) :- a(?x, n99).

% ARC checks

arc(check1, "C1 OK - the starting classification n0 is present.") :-
 once(a(ind, n0)).

arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1.") :-
 once(a(ind, n1)),
 once(a(ind, i1)),
 once(a(ind, j1)).

arc(check3, "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches.") :-
 once(a(ind, n50)),
 once(a(ind, i50)),
 once(a(ind, j50)).

arc(check4, "C4 OK - the final taxonomy step from n99 to n100 was completed.") :-
 once(a(ind, n99)),
 once(a(ind, n100)).

arc(check5, "C5 OK - once n100 is reached, the terminal class a2 is derived.") :-
 once(a(ind, n100)),
 once(a(ind, a2)).

arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present.") :-
 once(a(ind, a2)),
 once(is(test, true)).

% ARC report

answer(report, "The test succeeds: starting from one individual classified as n0, the rules eventually classify it as n100 and then as a2.") :-
 once(is(test, true)).

reason(report, "The adjacent rules mirror the Eyeling N3 deep-taxonomy-100 chain: each rule advances one taxonomy level and adds the matching side labels.") :-
 once(a(ind, a2)),
 once(is(test, true)).

checkPassed(report, ?check) :-
 arc(?check, ?_message).

result(report, success) :-
 once(is(test, true)),
 once(arc(check1, ?_c1)),
 once(arc(check2, ?_c2)),
 once(arc(check3, ?_c3)),
 once(arc(check4, ?_c4)),
 once(arc(check5, ?_c5)),
 once(arc(check6, ?_c6)).
