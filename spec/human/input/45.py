from fractions import Fraction

def problem_45_pre(side, high):
    return side >= 0 and high >= 0

def problem_45_spec(side, high, output):
    try:
        # Coq's R (Real) type represents exact mathematical real numbers.
        # When concrete float inputs are provided, they are typically interpreted 
        # as the exact rational numbers they represent in binary floating point.
        # Fraction(x) in Python extracts that exact rational value.
        # This ensures that we check for exact mathematical equality without 
        # intermediate floating-point rounding errors.
        return Fraction(output) == (Fraction(side) * Fraction(high)) / Fraction(2)
    except (ValueError, TypeError, OverflowError, ZeroDivisionError):
        # Fallback for non-finite values (inf, nan) or other non-numeric types
        # where Fraction conversion fails.
        try:
            return output == (side * high / 2.0)
        except Exception:
            return False
