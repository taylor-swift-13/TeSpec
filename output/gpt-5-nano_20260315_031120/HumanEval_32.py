import math

import numbers

def precondition(input) -> bool:
    try:
        if not isinstance(input, tuple) or len(input) != 1:
            return False
        xs = input[0]
        if not isinstance(xs, list):
            return False
        if len(xs) == 0 or len(xs) % 2 != 0:
            return False
        for c in xs:
            if not isinstance(c, numbers.Real) or isinstance(c, bool):
                return False
        if xs[-1] == 0:
            return False
        return True
    except Exception:
        return False

def postcondition(input, output) -> bool:
    try:
        if not isinstance(input, tuple) or len(input) != 1:
            return False
        xs = input[0]
        if not isinstance(xs, list) or len(xs) == 0 or len(xs) % 2 != 0:
            return False
        if not isinstance(output, numbers.Real) or isinstance(output, bool):
            return False
        x = output
        total = 0.0
        for i, coeff in enumerate(xs):
            total += float(coeff) * (x ** i)
        return abs(total) <= 1e-6
    except Exception:
        return False

def _impl(xs: list):
    """xs are coefficients of a polynomial.
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
