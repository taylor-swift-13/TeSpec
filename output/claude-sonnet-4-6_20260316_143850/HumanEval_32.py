import math

def precondition(input) -> bool:
    try:
        xs = input[0]
        if not isinstance(xs, list):
            return False
        if len(xs) == 0:
            return False
        # Must have even number of coefficients
        if len(xs) % 2 != 0:
            return False
        # All elements must be numeric
        for x in xs:
            if not isinstance(x, (int, float)):
                return False
        # Largest non-zero coefficient must be the last one (guarantees a solution)
        # Check that the last coefficient is non-zero
        if xs[-1] == 0:
            return False
        return True
    except Exception:
        return False


def postcondition(input, output) -> bool:
    try:
        xs = input[0]
        if not isinstance(output, (int, float)):
            return False
        # Verify that poly(output) is approximately 0
        result = 0.0
        for i, coef in enumerate(xs):
            result += coef * (output ** i)
        if abs(result) > 1e-3:
            return False
        return True
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
