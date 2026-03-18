import math

def poly(xs: list, x: float):
    """
    Evaluates polynomial with coefficients xs at point x.
    return xs[0] + xs[1] * x + xs[1] * x^2 + .... xs[n] * x^n
    """
    return sum([coeff * math.pow(x, i) for i, coeff in enumerate(xs)])

import math
from typing import Sequence

def _is_real_number(x):
    return (isinstance(x, (int, float)) and not isinstance(x, bool)
            and math.isfinite(x))

def precondition(input):
    # input is a tuple of positional args; expect one arg: xs
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    xs = input[0]
    if not isinstance(xs, Sequence) or isinstance(xs, (str, bytes, bytearray)):
        return False
    # must have even number of coefficients, at least 2
    n = len(xs)
    if n < 2 or (n % 2) != 0:
        return False
    # all elements must be real finite numbers (no bools) and at least one nonzero
    has_nonzero = False
    for a in xs:
        if not _is_real_number(a):
            return False
        if a != 0:
            has_nonzero = True
    if not has_nonzero:
        return False
    return True

def postcondition(input, output):
    # If precondition not met, do not enforce postcondition here.
    if not precondition(input):
        return True
    xs = input[0]
    # output must be a real finite number
    if not _is_real_number(output):
        return False
    x = float(output)
    n = len(xs)
    # evaluate polynomial in both common coefficient orders:
    # high-to-low: xs[0]*x^(n-1) + ... + xs[-1]
    try:
        poly_high = 0.0
        for i, a in enumerate(xs):
            # power might be large; do incremental Horner to be numerically better
            # Horner for high-to-low:
            if i == 0:
                poly_high = float(a)
            else:
                poly_high = poly_high * x + float(a)
    except Exception:
        return False
    try:
        # low-to-high: xs[0] + xs[1]*x + xs[2]*x^2 + ...
        poly_low = 0.0
        pow_x = 1.0
        for a in xs:
            poly_low += float(a) * pow_x
            pow_x *= x
    except Exception:
        return False
    # both evaluations must be finite numbers
    if not (math.isfinite(poly_high) and math.isfinite(poly_low)):
        return False
    # accept if either interpretation yields a value close to zero
    tol = 1e-7
    if abs(poly_high) <= tol or abs(poly_low) <= tol:
        return True
    # Also consider relative tolerance based on coefficient magnitudes
    max_coeff_sum = sum(abs(float(a)) for a in xs)
    rel_tol = 1e-9 * max(1.0, max_coeff_sum)
    if abs(poly_high) <= rel_tol or abs(poly_low) <= rel_tol:
        return True
    return False

def _impl(xs: list):
    """
    xs are coefficients of a polynomial.
    find_zero find x such that poly(x) = 0.
    find_zero returns only only zero point, even if there are many.
    Moreover, find_zero only takes list xs having even number of coefficients
    and largest non zero coefficient as it guarantees
    a solution.
    -0.5
    1.0
    """
    dxs = [xs[i] * i for i in range(1, len(xs))]
    def func(x):
        return poly(xs, x)
    def derivative(x):
        return poly(dxs, x)

    x, tol = 0, 1e-5
    for _ in range(1000):
        fx = func(x)
        dfx = derivative(x)
        if abs(fx) < tol: break
        x = x - fx / dfx

    return x

def find_zero(xs: list):
    _input = (xs,)
    assert precondition(_input)
    _output = _impl(xs)
    assert postcondition(_input, _output)
    return _output
