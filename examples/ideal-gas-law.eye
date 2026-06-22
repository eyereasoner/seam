% Science example: ideal gas law.
%
% A simple gas cell uses P*V = n*R*T.  The constants are chosen so that the
% computed pressure is exactly near one atmosphere in this small example.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(pressure_Pa, 2).
materialize(status, 2).
materialize(reason, 2).

% gas_cell/5 records n, R, T, and V; pressure_limit/3 gives the tolerance band
% used to classify the result as near atmospheric.
gas_cell(cell1, 1.0, 8.0, 300.0, 0.024).
pressure_limit(cell1, low_Pa, 95000.0).
pressure_limit(cell1, high_Pa, 105000.0).

% pressure/2 computes nRT/V in three explicit arithmetic steps so the proof
% output exposes numerator construction and final division.
pressure(?cell, ?pressure) :-
  gas_cell(?cell, ?moles, ?gasconstant, ?temperature, ?volume),
  mul(?moles, ?gasconstant, ?nr),
  mul(?nr, ?temperature, ?nrt),
  div(?nrt, ?volume, ?pressure).

near_atmospheric(?cell) :-
  pressure(?cell, ?pressure),
  pressure_limit(?cell, low_Pa, ?low),
  pressure_limit(?cell, high_Pa, ?high),
  gt(?pressure, ?low),
  lt(?pressure, ?high).

pressure_Pa(?cell, ?pressure) :-
  pressure(?cell, ?pressure).

status(?cell, near_atmospheric) :-
  near_atmospheric(?cell).

reason(?cell, "pressure is inside the one-atmosphere tolerance band") :-
  near_atmospheric(?cell).
