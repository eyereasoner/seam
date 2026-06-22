% Engineering example: cantilever beam tip deflection.
% The beam is modeled with load, span length, elastic modulus, and second moment
% of area.  The rules compute F*L^3/(3*E*I), convert meters to millimeters, and
% classify the design against a deflection limit.

materialize(type, 2).
materialize(tipDeflection_m, 2).
materialize(tipDeflection_mm, 2).
materialize(limit_mm, 2).
materialize(status, 2).

beam(beam1, force_N, 1200.0).
beam(beam1, length_m, 2.5).
beam(beam1, elasticModulus_Pa, 200000000000.0).
beam(beam1, secondMoment_m4, 0.000008).
limit(beam1, maxDeflection_mm, 5.0).

tip_deflection_m(?beam, ?deflection) :-
  beam(?beam, force_N, ?force),
  beam(?beam, length_m, ?length),
  beam(?beam, elasticModulus_Pa, ?elasticmodulus),
  beam(?beam, secondMoment_m4, ?secondmoment),
  pow(?length, 3.0, ?lengthcubed),
  mul(?force, ?lengthcubed, ?numerator),
  mul(3.0, ?elasticmodulus, ?threee),
  mul(?threee, ?secondmoment, ?denominator),
  div(?numerator, ?denominator, ?deflection).

tip_deflection_mm(?beam, ?deflectionmm) :-
  tip_deflection_m(?beam, ?deflectionm),
  mul(?deflectionm, 1000.0, ?deflectionmm).

type(?beam, cantilever_beam) :-
  beam(?beam, force_N, ?_force).

tipDeflection_m(?beam, ?deflectionm) :-
  tip_deflection_m(?beam, ?deflectionm).

tipDeflection_mm(?beam, ?deflectionmm) :-
  tip_deflection_mm(?beam, ?deflectionmm).

limit_mm(?beam, ?limit) :-
  limit(?beam, maxDeflection_mm, ?limit).

status(?beam, within_deflection_limit) :-
  tip_deflection_mm(?beam, ?deflectionmm),
  limit(?beam, maxDeflection_mm, ?limit),
  le(?deflectionmm, ?limit).
