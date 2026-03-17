
def precondition(input):
    xs = input[0]
    return isinstance(xs, list) and all(isinstance(x, (int, float)) for x in xs)

def postcondition(input, output):
    xs = input[0]
    if not isinstance(output, list):
        return False
    if not xs:
        return output == []
    expected_len = max(0, len(xs) - 1)
    return len(output) == expected_len and all(isinstance(x, (int, float)) for x in output)

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
