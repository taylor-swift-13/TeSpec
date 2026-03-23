from fractions import Fraction

from decimal import Decimal

def _orig_triangle_area_spec(a, h, output):
    try:
        a_f = Fraction(Decimal(str(a)))
        h_f = Fraction(Decimal(str(h)))
        res_f = Fraction(Decimal(str(output)))
        return res_f == a_f * h_f / 2
    except Exception:
        return False

def triangle_area_spec(a, h, output):
    return bool(_orig_triangle_area_spec(a, h, output))
