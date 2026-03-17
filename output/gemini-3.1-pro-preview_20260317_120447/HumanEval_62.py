
def precondition(args):
    if len(args) != 1:
        return False
    xs = args[0]
    if not isinstance(xs, list):
        return False
    return all(isinstance(x, (int, float)) for x in xs)

def postcondition(args, output):
    xs = args[0]
    if not isinstance(output, list):
        return False
    expected = [xs[i] * i for i in range(1, len(xs))]
    if len(output) != len(expected):
        return False
    return all(a == b for a, b in zip(output, expected))

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
