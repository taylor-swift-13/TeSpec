
def precondition(input):
    (xs,) = input
    # xs must be a list of numbers with at least 2 coefficients (so derivative is non-empty)
    if not isinstance(xs, list):
        return False
    if len(xs) < 2:
        return False
    for x in xs:
        if not isinstance(x, (int, float)):
            return False
    return True


def postcondition(input, output):
    (xs,) = input
    # output should be a list
    if not isinstance(output, list):
        return False
    # derivative of polynomial of degree n (n+1 coefficients) has degree n-1 (n coefficients)
    if len(output) != len(xs) - 1:
        return False
    # Check each coefficient of the derivative: d/dx of xs[i]*x^i = i*xs[i]*x^(i-1)
    for i in range(len(output)):
        expected = (i + 1) * xs[i + 1]
        if abs(output[i] - expected) > 1e-9:
            return False
    return True

def _impl(xs: list):
    """xs represent coefficients of a polynomial.
    xs[0] + xs[1] * x + xs[2] * x^2 + ....
     Return derivative of this polynomial in the same form.
    [1, 4, 12, 20]
    [2, 6]"""
    return [xs[i] * i for i in range(1, len(xs))]

def derivative(xs: list):
    _input = (xs,)
    assert precondition(_input)
    _output = _impl(xs)
    assert postcondition(_input, _output)
    return _output
