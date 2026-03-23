import math
from fractions import Fraction

def triangle_area_spec(a, b, c, area):
    try:
        # Convert inputs to exact rational numbers.
        # By passing floats directly to Fraction(), we get their exact binary fraction representation.
        # This perfectly matches Coq's exact real arithmetic, where a float like 0.1 is not exactly 1/10.
        fa = Fraction(a)
        fb = Fraction(b)
        fc = Fraction(c)
        farea = Fraction(area)
    except Exception:
        return False

    # Check triangle inequality: a + b <= c \/ a + c <= b \/ b + c <= a
    # If any of these hold, the triangle is invalid or degenerate, and area must be -1.
    if fa + fb <= fc or fa + fc <= fb or fb + fc <= fa:
        return farea == Fraction(-1)

    # Valid triangle logic: Heron's formula
    # p = (a + b + c) / 2
    p = (fa + fb + fc) / Fraction(2)

    # V = p * (p - a) * (p - b) * (p - c)
    V = p * (p - fa) * (p - fb) * (p - fc)

    # We want to find k that minimizes |sqrt(V) * 100 - k|
    # This is equivalent to minimizing |sqrt(10000 * V) - k|
    U = Fraction(10000) * V

    # Find f = floor(sqrt(U)).
    # We use isqrt(num * den) // den which is mathematically equivalent to floor(sqrt(num/den)).
    f = math.isqrt(U.numerator * U.denominator) // U.denominator

    # The closest integer k to sqrt(U) must be either f or f + 1.
    # We compare sqrt(U) to the midpoint f + 0.5.
    # sqrt(U) < f + 0.5  <=>  U < (f + 0.5)^2  <=>  4 * U < (2 * f + 1)^2
    W = Fraction(4) * U
    mid_sq = (2 * f + 1) ** 2

    if W < mid_sq:
        k = f
    elif W > mid_sq:
        k = f + 1
    else:
        # Tie case: W == mid_sq. sqrt(U) is exactly f + 0.5.
        # The spec requires picking the even integer (Zeven k).
        # Since f and f+1 are consecutive, one is even and one is odd.
        k = f if f % 2 == 0 else f + 1

    # The spec requires exact equality: area = IZR k / 100
    return farea == Fraction(k, 100)
