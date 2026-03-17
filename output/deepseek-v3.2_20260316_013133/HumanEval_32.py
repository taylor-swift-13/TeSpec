import math

def precondition(input):
    xs, = input
    if not isinstance(xs, list):
        return False
    if len(xs) == 0:
        return False
    if len(xs) % 2 != 0:
        return False
    non_zero_found = False
    for coeff in xs:
        if not isinstance(coeff, (int, float)):
            return False
        if coeff != 0.0:
            non_zero_found = True
    return non_zero_found

def postcondition(input, output):
    xs, = input
    if not isinstance(output, (int, float)):
        return False
    if not isinstance(xs, list):
        return False
    if len(xs) == 0:
        return False
    poly_val = 0.0
    for i, coeff in enumerate(xs):
        poly_val += coeff * (output ** i)
    return abs(poly_val) < 1e-9

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
