from fractions import Fraction
import math

def _orig_problem_45_pre(side, high):
    return side >= 0 and high >= 0

# 旧版本用 Fraction 做精确比较，容易和官方 float 结果错开。
# def _orig_problem_45_spec(side, high, output):
#     try:
#         return Fraction(output) == Fraction(side) * Fraction(high) / Fraction(2)
#     except (ValueError, TypeError, OverflowError, ZeroDivisionError):
#         try:
#             return output == side * high / 2.0
#         except Exception:
#             return False

def _orig_problem_45_spec(side, high, output):
    try:
        expected = side * high / 2.0
        return math.isclose(output, expected, rel_tol=1e-12, abs_tol=1e-12)
    except Exception:
        return False

def problem_45_pre(a, h):
    return bool(_orig_problem_45_pre(a, h))

def problem_45_spec(a, h, output):
    return bool(_orig_problem_45_spec(a, h, output))
