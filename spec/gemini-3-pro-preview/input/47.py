from fractions import Fraction

def _orig_median_spec(l, output):
    n = len(l)
    if n == 0:
        return False
    sorted_l = sorted(l)
    if n % 2 != 0:
        expected = Fraction(sorted_l[n // 2])
    else:
        expected = Fraction(sorted_l[n // 2 - 1] + sorted_l[n // 2], 2)
    return output == expected

def median_spec(l, output):
    return bool(_orig_median_spec(l, output))
