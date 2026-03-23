from fractions import Fraction
from decimal import Decimal

def triangle_area_spec(a, h, res):
    try:
        # Use Decimal(str(x)) to handle scientific notation and preserve decimal values
        a_f = Fraction(Decimal(str(a)))
        h_f = Fraction(Decimal(str(h)))
        res_f = Fraction(Decimal(str(res)))
        return res_f == a_f * h_f / 2
    except Exception:
        return False
