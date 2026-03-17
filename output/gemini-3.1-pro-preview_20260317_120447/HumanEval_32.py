import math

def precondition(input):
    xs = input[0]
    return isinstance(xs, list) and len(xs) > 0 and len(xs) % 2 == 0 and xs[-1] != 0

def postcondition(input, output):
    xs = input[0]
    x = output
    if not isinstance(x, (int, float)):
        return False
    res = sum(c * (x ** i) for i, c in enumerate(xs))
    return abs(res) < 1e-3

def _impl(xs: list):
    """xs are coefficients of a polynomial.
    find_zero find x such that poly(x) = 0.
    find_zero returns only only zero point, even if there are many.
    Moreover, find_zero only takes list xs having even number of coefficients
    and largest non zero coefficient as it guarantees
    a solution.
    -0.5
    1.0"""
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
