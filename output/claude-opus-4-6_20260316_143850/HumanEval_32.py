import math

def precondition(input):
    xs = input[0]
    # xs must be a list
    if not isinstance(xs, list):
        return False
    # xs must have even number of coefficients
    if len(xs) % 2 != 0:
        return False
    # xs must have at least 2 elements (non-trivial polynomial)
    if len(xs) < 2:
        return False
    # all coefficients must be numbers
    for x in xs:
        if not isinstance(x, (int, float)):
            return False
    # largest non-zero coefficient (the leading coefficient must be non-zero)
    # This guarantees a solution exists
    if xs[-1] == 0:
        return False
    return True


def postcondition(input, output):
    xs = input[0]
    # output must be a number
    if not isinstance(output, (int, float)):
        return False
    # Evaluate the polynomial at the output point
    # poly(x) = xs[0] + xs[1]*x + xs[2]*x^2 + ...
    result = 0
    for i, c in enumerate(xs):
        result += c * (output ** i)
    # The result should be approximately zero
    if abs(result) > 1e-4:
        return False
    return True

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
