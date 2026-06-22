% Adapted from Eyeling's fft8-numeric.n3.
%
% This is an 8-point radix-2 FFT over explicit complex pairs c(Real, Imag).
% The rules are deliberately unrolled enough to keep proofs readable while still
% showing butterfly composition, twiddle factors, and selected output bins.
materialize(fft, 2).
materialize(dcComponent, 2).

% Twiddle factors are encoded as complex pairs.  Keeping them as facts makes the
% numerical transform deterministic and keeps every multiplication visible.
w8(0, c(1.0, 0.0)).
w8(1, c(0.7071067811865476, -0.7071067811865476)).
w8(2, c(0.0, -1.0)).
w8(3, c(-0.7071067811865476, -0.7071067811865476)).
w8(4, c(-1.0, 0.0)).
w8(5, c(-0.7071067811865476, 0.7071067811865476)).
w8(6, c(0.0, 1.0)).
w8(7, c(0.7071067811865476, 0.7071067811865476)).

% Complex arithmetic is expressed through ordinary numeric built-ins.  These
% helpers are then composed into two-point, four-point, and eight-point FFTs.
c_add(c(?ar, ?ai), c(?br, ?bi), c(?cr, ?ci)) :-
  add(?ar, ?br, ?cr),
  add(?ai, ?bi, ?ci).

c_sub(c(?ar, ?ai), c(?br, ?bi), c(?cr, ?ci)) :-
  sub(?ar, ?br, ?cr),
  sub(?ai, ?bi, ?ci).

c_mul(c(?ar, ?ai), c(?br, ?bi), c(?cr, ?ci)) :-
  mul(?ar, ?br, ?ac),
  mul(?ai, ?bi, ?bd),
  sub(?ac, ?bd, ?cr),
  mul(?ar, ?bi, ?ad),
  mul(?ai, ?br, ?bc),
  add(?ad, ?bc, ?ci).

fft1([?x], [c(?x, 0.0)]).

fft2([?x0, ?x1], [?y0, ?y1]) :-
  fft1([?x0], [?e0]),
  fft1([?x1], [?o0]),
  c_add(?e0, ?o0, ?y0),
  c_sub(?e0, ?o0, ?y1).

fft4([?x0, ?x1, ?x2, ?x3], [?y0, ?y1, ?y2, ?y3]) :-
  fft2([?x0, ?x2], [?e0, ?e1]),
  fft2([?x1, ?x3], [?o0, ?o1]),
  w8(2, ?w1),
  c_mul(?w1, ?o1, ?t1),
  c_add(?e0, ?o0, ?y0),
  c_add(?e1, ?t1, ?y1),
  c_sub(?e0, ?o0, ?y2),
  c_sub(?e1, ?t1, ?y3).

% Split even/odd samples, transform halves, then combine with W8 factors.
% fft8/2 composes two four-point FFTs with the four required twiddle factors.
fft8([?x0, ?x1, ?x2, ?x3, ?x4, ?x5, ?x6, ?x7], [?y0, ?y1, ?y2, ?y3, ?y4, ?y5, ?y6, ?y7]) :-
  fft4([?x0, ?x2, ?x4, ?x6], [?e0, ?e1, ?e2, ?e3]),
  fft4([?x1, ?x3, ?x5, ?x7], [?o0, ?o1, ?o2, ?o3]),
  w8(1, ?w1),
  w8(2, ?w2),
  w8(3, ?w3),
  c_mul(?w1, ?o1, ?t1),
  c_mul(?w2, ?o2, ?t2),
  c_mul(?w3, ?o3, ?t3),
  c_add(?e0, ?o0, ?y0),
  c_add(?e1, ?t1, ?y1),
  c_add(?e2, ?t2, ?y2),
  c_add(?e3, ?t3, ?y3),
  c_sub(?e0, ?o0, ?y4),
  c_sub(?e1, ?t1, ?y5),
  c_sub(?e2, ?t2, ?y6),
  c_sub(?e3, ?t3, ?y7).

wave(ramp8, [0, 1, 2, 3, 4, 5, 6, 7]).
wave(alternating8, [1, -1, 1, -1, 1, -1, 1, -1]).

fft(?wave, ?spectrum) :-
  wave(?wave, ?samples),
  fft8(?samples, ?spectrum).

dcComponent(?wave, ?dc) :-
  wave(?wave, ?samples),
  fft8(?samples, [?dc|?_]).
