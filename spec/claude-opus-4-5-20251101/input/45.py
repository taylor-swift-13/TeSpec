from fractions import Fraction

def _to_frac(x):
    try:
        return Fraction(x)
    except Exception:
        pass
    if hasattr(x, 'as_integer_ratio'):
        try:
            return Fraction(*x.as_integer_ratio())
        except Exception:
            pass
    try:
        return Fraction(str(x))
    except Exception:
        return Fraction(float(x))

def triangle_area_spec(a, h, area):
    try:
        fa = _to_frac(a)
        fh = _to_frac(h)
        farea = _to_frac(area)
        return farea == (fa * fh) / 2
    except Exception:
        return False
