
from collections.abc import Sequence
import numbers
import math

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    xs = input[0]
    if not isinstance(xs, Sequence):
        return False
    # Ensure elements are numeric (allow int, float, complex, Decimal, etc.)
    for x in xs:
        if not isinstance(x, numbers.Number):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    xs = input[0]
    if not isinstance(output, Sequence):
        return False
    expected_len = max(len(xs) - 1, 0)
    if len(output) != expected_len:
        return False

    def num_equal(a, b):
        # If either is complex, require exact equality
        if isinstance(a, complex) or isinstance(b, complex):
            return a == b
        try:
            if a == b:
                return True
        except Exception:
            pass
        try:
            return math.isclose(float(a), float(b), rel_tol=1e-9, abs_tol=1e-12)
        except Exception:
            return False

    for j in range(expected_len):
        expected = (j + 1) * xs[j + 1]
        actual = output[j]
        if not isinstance(actual, numbers.Number):
            return False
        if not num_equal(actual, expected):
            return False
    return True

def _impl(xs: list):
    """xs represent coefficients of a polynomial.
    xs[0] + xs[1] * x + xs[2] * x^2 + ....
     Return derivative of this polynomial in the same form.
    [1, 4, 12, 20]
    [2, 6]"""
    return [xs[i] * i for i in range(1, len(xs))]

def derivative(xs: list):
    _input = (xs,)
    assert precondition(_input)
    _output = _impl(xs)
    assert postcondition(_input, _output)
    return _output
