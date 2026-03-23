from fractions import Fraction

def _orig_median_spec(l, m):
    n = len(l)
    if n == 0:
        return False
    sl = sorted(l)
    mid = n // 2
    if n % 2 != 0:
        expected = Fraction(sl[mid])
    else:
        expected = Fraction(sl[mid - 1] + sl[mid], 2)
    return m == expected

def median_spec(l, output):
    return bool(_orig_median_spec(l, output))
