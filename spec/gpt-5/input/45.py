from fractions import Fraction

def triangle_area_spec(a, h, area):
    try:
        a_f = Fraction(str(a)) if isinstance(a, float) else Fraction(a)
        h_f = Fraction(str(h)) if isinstance(h, float) else Fraction(h)
        area_f = Fraction(str(area)) if isinstance(area, float) else Fraction(area)
        return area_f == (a_f * h_f) / Fraction(2)
    except Exception:
        return area == (a * h) / 2.0
