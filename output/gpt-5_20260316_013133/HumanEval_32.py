import math

def poly(xs: list, x: float):
    """
    Evaluates polynomial with coefficients xs at point x.
    return xs[0] + xs[1] * x + xs[1] * x^2 + .... xs[n] * x^n
    """
    return sum([coeff * math.pow(x, i) for i, coeff in enumerate(xs)])

def precondition(input):
    import math
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    xs = input[0]
    if not isinstance(xs, list):
        return False
    n = len(xs)
    if n < 2 or (n % 2) != 0:
        return False
    # all coefficients must be real finite numbers
    for c in xs:
        if not isinstance(c, (int, float)):
            return False
        if math.isnan(c) or math.isinf(c):
            return False
    # leading (highest-degree) coefficient must be non-zero to ensure odd degree
    if xs[-1] == 0:
        return False
    return True

def postcondition(input, output):
    import math
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    xs = input[0]
    # output should be a single real finite number
    if not isinstance(output, (int, float)):
        return False
    if math.isnan(output) or math.isinf(output):
        return False
    # evaluate polynomial at output using Horner's method
    try:
        x = float(output)
        # compute value and a conservative scale for tolerance
        val = 0.0
        for c in reversed(xs):
            val = val * x + float(c)
        M = max(1.0, abs(x))
        scale = 0.0
        powM = 1.0
        for c in xs:
            scale += abs(float(c)) * powM
            powM *= M
        tol = 1e-7 * (1.0 + scale)
        if not math.isfinite(val):
            return False
        return abs(val) <= tol or val == 0.0
    except Exception:
        return False

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
