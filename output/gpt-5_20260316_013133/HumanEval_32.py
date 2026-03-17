import math

def precondition(input):
    # Expect a single positional argument: xs (list of coefficients)
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    xs = input[0]
    if not isinstance(xs, list):
        return False
    n = len(xs)
    # Even number of coefficients and at least 2 to ensure odd degree >= 1
    if n < 2 or (n % 2) != 0:
        return False
    # Helper to check finite real numbers without imports
    def is_finite_number(v):
        if not isinstance(v, (int, float)):
            return False
        # NaN check: v != v is True for NaN
        if v != v:
            return False
        # Infinity checks
        if v == float('inf') or v == float('-inf'):
            return False
        return True
    # All coefficients must be finite real numbers
    for c in xs:
        if not is_finite_number(c):
            return False
    # Leading (highest-degree) coefficient must be non-zero
    if xs[-1] == 0:
        return False
    return True

def postcondition(input, output):
    # If precondition doesn't hold, do not enforce postconditions
    if not precondition(input):
        return True
    xs = input[0]
    # Helper to check finite real numbers without imports
    def is_finite_number(v):
        if not isinstance(v, (int, float)):
            return False
        if v != v:
            return False
        if v == float('inf') or v == float('-inf'):
            return False
        return True
    # Output should be a single finite real number
    if not is_finite_number(output):
        return False
    x = float(output)
    # Evaluate polynomial using Horner's method and accumulate a scale for tolerance
    val = 0.0
    scale = 0.0
    ax = abs(x)
    for c in reversed(xs):
        val = val * x + float(c)
        scale = scale * ax + abs(float(c))
    # Tolerance scaled by polynomial magnitude at |x|
    tol = 1e-7 * (1.0 + scale)
    return abs(val) <= tol

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
