import math

def poly(xs: list, x: float):
    """
    Evaluates polynomial with coefficients xs at point x.
    return xs[0] + xs[1] * x + xs[1] * x^2 + .... xs[n] * x^n
    """
    return sum([coeff * math.pow(x, i) for i, coeff in enumerate(xs)])

def precondition(input):
    # input is a tuple of positional arguments; here only xs is expected
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    xs = input[0]
    if not isinstance(xs, list):
        return False
    n = len(xs)
    # require at least two coefficients, and even number of coefficients
    if n < 2 or (n % 2) != 0:
        return False
    # all coefficients should be numeric
    for c in xs:
        if not isinstance(c, (int, float)):
            return False
    # leading coefficient should be non-zero to guarantee a polynomial of correct degree
    if xs[0] == 0:
        return False
    return True

def postcondition(input, output):
    # Check that output is a real number (not NaN/Inf)
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    xs = input[0]
    if not isinstance(xs, list) or len(xs) < 2 or (len(xs) % 2) != 0:
        return False
    if not isinstance(output, (int, float)):
        return False
    if isinstance(output, float) and (output != output):  # NaN
        return False
    if (isinstance(output, float) and (output == float('inf') or output == float('-inf'))):
        return False

    # Evaluate polynomial using Horner's method.
    # xs is assumed to be coefficients in descending order: [a_n, a_{n-1}, ..., a_0]
    def poly_value(coefs, x):
        v = 0.0
        for a in coefs:
            v = v * x + a
        return v

    p = poly_value(xs, output)
    tol = 1e-6
    if abs(p) > tol:
        return False
    return True

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
