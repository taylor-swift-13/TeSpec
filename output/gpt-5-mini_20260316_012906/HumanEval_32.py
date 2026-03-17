import math

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    xs = input[0]
    if not isinstance(xs, (list, tuple)):
        return False
    n = len(xs)
    # require at least two coefficients and an even number of them
    if n < 2 or (n % 2) != 0:
        return False
    # coefficients must be real finite numbers
    try:
        import math
        for c in xs:
            if not isinstance(c, (int, float)):
                return False
            if not math.isfinite(c):
                return False
    except Exception:
        return False
    # leading (highest-degree) coefficient must be non-zero to ensure degree = n-1
    if xs[-1] == 0:
        return False
    return True

def postcondition(input, output):
    # only check postcondition when precondition holds
    if not precondition(input):
        return True
    xs = input[0]
    # output must be a real finite number
    if not isinstance(output, (int, float)):
        return False
    import math
    if not math.isfinite(output):
        return False
    x = float(output)
    # evaluate polynomial at x using Horner's method (coeffs assumed [a0, a1, ..., an])
    try:
        val = 0.0
        for a in reversed(xs):
            val = val * x + float(a)
    except Exception:
        return False
    # accept small numerical error
    return abs(val) <= 1e-7

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
