import math

def poly(xs: list, x: float):
    """
    Evaluates polynomial with coefficients xs at point x.
    return xs[0] + xs[1] * x + xs[1] * x^2 + .... xs[n] * x^n
    """
    return sum([coeff * math.pow(x, i) for i, coeff in enumerate(xs)])

def precondition(inputs):
    if len(inputs) != 1:
        return False
    xs = inputs[0]
    if not isinstance(xs, list):
        return False
    if len(xs) == 0 or len(xs) % 2 != 0:
        return False
    if not all(isinstance(c, (int, float)) for c in xs):
        return False
    return True

def postcondition(inputs, output):
    xs = inputs[0]
    if not isinstance(output, (int, float)):
        return False
    try:
        res = sum(c * (output ** i) for i, c in enumerate(xs))
        return abs(res) < 1e-2
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
