import math

import math

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    xs, x = input
    if not isinstance(xs, list):
        return False
    # coefficients may be empty list
    for a in xs:
        # reject booleans
        if isinstance(a, bool):
            return False
        if not isinstance(a, (int, float)):
            return False
        # finite numeric values only
        try:
            if not math.isfinite(float(a)):
                return False
        except Exception:
            return False
    # check x
    if isinstance(x, bool):
        return False
    if not isinstance(x, (int, float)):
        return False
    try:
        if not math.isfinite(float(x)):
            return False
    except Exception:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    if not precondition(input):
        return False
    xs, x = input
    # output must be numeric (not bool)
    if isinstance(output, bool):
        return False
    if not isinstance(output, (int, float)):
        return False
    try:
        fo = float(output)
    except Exception:
        return False
    # compute expected value using float arithmetic
    fx = float(x)
    expected = 0.0
    try:
        for i, a in enumerate(xs):
            expected += float(a) * (fx ** i)
    except Exception:
        return False
    # NaNs are not accepted
    if math.isnan(expected) or math.isnan(fo):
        return False
    # handle infinities: must match sign
    if math.isinf(expected) or math.isinf(fo):
        return math.isinf(expected) and math.isinf(fo) and (math.copysign(1.0, expected) == math.copysign(1.0, fo))
    # finite values: allow small floating point error
    return math.isclose(fo, expected, rel_tol=1e-9, abs_tol=1e-12)

def _impl(xs: list, x: float):
    """Evaluates polynomial with coefficients xs at point x.
    return xs[0] + xs[1] * x + xs[1] * x^2 + .... xs[n] * x^n"""
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

def poly(xs: list, x: float):
    _input = (xs, x)
    assert precondition(_input)
    _output = _impl(xs, x)
    assert postcondition(_input, _output)
    return _output
