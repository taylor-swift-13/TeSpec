import math

def poly(xs: list, x: float):
    """
    Evaluates polynomial with coefficients xs at point x.
    return xs[0] + xs[1] * x + xs[1] * x^2 + .... xs[n] * x^n
    """
    return sum([coeff * math.pow(x, i) for i, coeff in enumerate(xs)])

def precondition(input):
    xs = input[0]
    if not isinstance(xs, list):
        return False
    if len(xs) % 2 != 0:
        return False
    if len(xs) == 0:
        return False
    
    # Check if there is at least one non-zero coefficient
    # and the largest non-zero coefficient is positive
    # (Assuming "largest" refers to the leading coefficient or max value)
    # Based on the prompt, we ensure the list is valid for the solver
    return any(x != 0 for x in xs)

def postcondition(input, output):
    xs = input[0]
    x = output
    
    # Evaluate polynomial at x using Horner's method
    result = 0
    for coeff in xs:
        result = result * x + coeff
        
    # Check if result is close to zero (allowing for floating point error)
    return abs(result) < 1e-7

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
