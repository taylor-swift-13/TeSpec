
def precondition(input):
    xs = input[0]
    if not isinstance(xs, list):
        return False
    if len(xs) == 0:
        return False
    for coeff in xs:
        if not isinstance(coeff, (int, float)):
            return False
    return True

def postcondition(input, output):
    xs = input[0]
    if not isinstance(output, list):
        return False
    if len(xs) == 1:
        return output == []
    if len(output) != len(xs) - 1:
        return False
    for coeff in output:
        if not isinstance(coeff, (int, float)):
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
