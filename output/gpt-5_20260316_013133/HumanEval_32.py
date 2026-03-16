import math

def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    xs, x = input
    if not isinstance(xs, list):
        return False
    if len(xs) < 1:
        return False
    try:
        import numbers
    except Exception:
        return False
    if not isinstance(x, numbers.Real):
        return False
    for c in xs:
        if not isinstance(c, numbers.Real):
            return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    xs, x = input
    try:
        import numbers, math
    except Exception:
        return False
    if not isinstance(output, numbers.Real):
        return False
    try:
        expected = 0
        for i, c in enumerate(xs):
            expected = expected + c * (x ** i)
    except Exception:
        return False
    # NaN handling
    try:
        exp_is_nan = expected != expected
    except Exception:
        exp_is_nan = False
    try:
        out_is_nan = output != output
    except Exception:
        out_is_nan = False
    if exp_is_nan or out_is_nan:
        return exp_is_nan and out_is_nan
    # Infinity handling
    e_float = None
    o_float = None
    try:
        e_float = float(expected)
        o_float = float(output)
    except Exception:
        pass
    if e_float is not None and o_float is not None:
        if math.isinf(e_float) or math.isinf(o_float):
            return e_float == o_float
    # Numeric closeness
    try:
        return math.isclose(expected, output, rel_tol=1e-9, abs_tol=1e-9)
    except Exception:
        try:
            return expected == output
        except Exception:
            return False

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
