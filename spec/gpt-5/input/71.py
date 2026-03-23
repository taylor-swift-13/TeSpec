import math

from fractions import Fraction

def _orig_triangle_area_spec(a, b, c, area):
    try:
        fa = Fraction(a)
        fb = Fraction(b)
        fc = Fraction(c)
        farea = Fraction(area)
    except Exception:
        return False
    if fa + fb <= fc or fa + fc <= fb or fb + fc <= fa:
        return farea == Fraction(-1)
    p = (fa + fb + fc) / Fraction(2)
    V = p * (p - fa) * (p - fb) * (p - fc)
    U = Fraction(10000) * V
    f = math.isqrt(U.numerator * U.denominator) // U.denominator
    W = Fraction(4) * U
    mid_sq = (2 * f + 1) ** 2
    if W < mid_sq:
        k = f
    elif W > mid_sq:
        k = f + 1
    else:
        k = f if f % 2 == 0 else f + 1
    return farea == Fraction(k, 100)

def triangle_area_spec(a, b, c, output):
    return bool(_orig_triangle_area_spec(a, b, c, output))
