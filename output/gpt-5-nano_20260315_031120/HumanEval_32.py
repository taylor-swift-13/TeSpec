import math

def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    xs, x = input
    if not isinstance(xs, (list, tuple)):
        return False
    if len(xs) == 0:
        return False
    for coef in xs:
        if not isinstance(coef, (int, float)):
            return False
    if not isinstance(x, (int, float)):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    xs, x = input
    if not isinstance(xs, (list, tuple)) or len(xs) == 0:
        return False
    for coef in xs:
        if not isinstance(coef, (int, float)):
            return False
    if not isinstance(x, (int, float)):
        return False
    if not isinstance(output, (int, float)):
        return False
    expected = 0.0
    for i, coef in enumerate(xs):
        expected += coef * (x ** i)
    tol = 1e-9 * max(1.0, abs(expected))
    return abs(output - expected) <= tol

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
