from fractions import Fraction

from decimal import Decimal
import math

def _orig_triangle_area_spec(a, h, output):
    try:
        expected = a * h / 2.0
        return math.isclose(output, expected, rel_tol=1e-12, abs_tol=1e-12)
    except Exception:
        return False

def triangle_area_spec(a, h, output):
    return bool(_orig_triangle_area_spec(a, h, output))
