from fractions import Fraction
import math

def sum_R(l):
    res = Fraction(0)
    for h in l:
        res += h
    return res

def Rdiv(x, y):
    # In Coq's Reals, division x / y is defined as x * /y.
    # Since 0 * r = 0 for any real r, 0 / 0 = 0 * /0 = 0.
    if y == 0:
        return Fraction(0)
    return x / y

def _orig_mean_absolute_deviation_spec(numbers, output):
    expected = sum(abs(x - (sum(numbers) / len(numbers))) for x in numbers) / len(numbers)
    return math.isclose(output, expected, rel_tol=1e-12, abs_tol=1e-12)

def mean_absolute_deviation_spec(numbers, output):
    return bool(_orig_mean_absolute_deviation_spec(numbers, output))
