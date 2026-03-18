import math

def poly(xs: list, x: float):
    """
    Evaluates polynomial with coefficients xs at point x.
    return xs[0] + xs[1] * x + xs[1] * x^2 + .... xs[n] * x^n
    """
    return sum([coeff * math.pow(x, i) for i, coeff in enumerate(xs)])

def precondition(input):
    xs = input[0]
    
    # xs must be a list
    if not isinstance(xs, list):
        return False
    
    # xs must have even number of coefficients
    if len(xs) % 2 != 0:
        return False
    
    # xs must have at least some coefficients
    if len(xs) == 0:
        return False
    
    # All coefficients must be numbers
    for coef in xs:
        if not isinstance(coef, (int, float)):
            return False
    
    # Largest non-zero coefficient (leading coefficient) must be non-zero
    # This means the last coefficient (highest degree) must be non-zero
    if xs[-1] == 0:
        return False
    
    return True


def postcondition(input, output):
    xs = input[0]
    
    # Output must be a number
    if not isinstance(output, (int, float)):
        return False
    
    # Evaluate polynomial at output: poly(output) should be approximately 0
    # poly(x) = xs[0] + xs[1]*x + xs[2]*x^2 + ...
    result = 0
    for i, coef in enumerate(xs):
        result += coef * (output ** i)
    
    # Check if result is close to zero (with tolerance for floating point)
    tolerance = 1e-4
    if abs(result) > tolerance:
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
