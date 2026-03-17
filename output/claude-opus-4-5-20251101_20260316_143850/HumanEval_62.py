
def precondition(input):
    xs, = input
    # xs must be a list
    if not isinstance(xs, list):
        return False
    # All elements must be numbers (int or float)
    for coef in xs:
        if not isinstance(coef, (int, float)):
            return False
    return True

def postcondition(input, output):
    xs, = input
    # Output must be a list
    if not isinstance(output, list):
        return False
    # All elements in output must be numbers
    for coef in output:
        if not isinstance(coef, (int, float)):
            return False
    # Derivative of polynomial of degree n has degree n-1
    # If xs has length 0 or 1, derivative should be empty list
    if len(xs) <= 1:
        return output == []
    # Otherwise, output should have length len(xs) - 1
    if len(output) != len(xs) - 1:
        return False
    # Check derivative coefficients: d/dx of xs[i] * x^i = i * xs[i] * x^(i-1)
    # So output[j] should equal (j+1) * xs[j+1]
    for j in range(len(output)):
        expected = (j + 1) * xs[j + 1]
        if output[j] != expected:
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
