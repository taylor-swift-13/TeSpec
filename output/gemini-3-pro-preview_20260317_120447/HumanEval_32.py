import math

def precondition(input_args):
    xs = input_args[0]
    if not isinstance(xs, list) or len(xs) == 0 or len(xs) % 2 != 0:
        return False
    # An odd-degree polynomial (even number of coefficients) 
    # is guaranteed to have at least one real root if the leading coefficient is non-zero.
    return xs[-1] != 0

def postcondition(input_args, output):
    xs = input_args[0]
    x = output
    if not isinstance(x, (int, float)):
        return False
    # Evaluate polynomial at x: sum(c * x^i)
    poly_val = sum(coeff * (x ** i) for i, coeff in enumerate(xs))
    # Check if the result is approximately zero
    return abs(poly_val) < 1e-6

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
