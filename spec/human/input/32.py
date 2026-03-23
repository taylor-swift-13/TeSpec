from fractions import Fraction

def eval_poly(coeffs, x):
    """
    Evaluates the polynomial with coefficients coeffs at point x.
    Uses exact Fraction arithmetic to match Coq's exact Real (R) evaluation.
    """
    res = Fraction(0)
    x_frac = Fraction(x)
    for c in reversed(coeffs):
        res = Fraction(c) + x_frac * res
    return res

def problem_32_pre(input):
    """
    Precondition: input list must be non-empty and have even length.
    """
    return len(input) > 0 and len(input) % 2 == 0

def problem_32_spec(input, output):
    """
    Postcondition: output must be a root of the polynomial defined by input.
    Checks exact equality to 0 to match Coq's exact Real equality.
    """
    return eval_poly(input, output) == 0
