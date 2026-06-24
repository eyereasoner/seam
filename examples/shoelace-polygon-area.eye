% Polygon area by the shoelace formula.
%
% The input polygon is the same closed polygon shape used by the source example:
% the final point repeats the first point.  Each recursive step consumes one
% adjacent pair and contributes `(x1*y2 - y1*x2) / 2` to the oriented area.

materialize(polygon_area, 2).

sample_polygon([[3, 2], [6, 2], [7, 6], [4, 6], [5, 5], [5, 3], [3, 2]]).

area([?_point], 0).
area([[?a, ?b], [?c, ?d]|?rest], ?total) :-
  area([[?c, ?d]|?rest], ?subtotal),
  mul(?a, ?d, ?ad),
  mul(?b, ?c, ?bc),
  sub(?ad, ?bc, ?cross),
  div(?cross, 2.0, ?half),
  add(?half, ?subtotal, ?total).

polygon_area(sample, ?area) :-
  sample_polygon(?points),
  area(?points, ?area).
