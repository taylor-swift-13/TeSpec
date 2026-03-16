
def precondition(input):
    # input is a tuple of positional arguments; expects exactly one argument xs which is a non-empty list/tuple of numbers
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    xs = input[0]
    if not isinstance(xs, (list, tuple)):
        return False
    if len(xs) < 1:
        return False
    for v in xs:
        if not isinstance(v, (int, float)):
            return False
    return True

def postcondition(input, output):
    # output should be the derivative coefficients: list/tuple of length len(xs)-1 with values i * xs[i] for i in 1..len(xs)-1
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    xs = input[0]
    if not isinstance(xs, (list, tuple)):
        return False
    if not isinstance(output, (list, tuple)):
        return False
    if len(output) != max(0, len(xs) - 1):
        return False
    for i in range(1, len(xs)):
        if not isinstance(output[i - 1], (int, float)):
            return False
        if output[i - 1] != i * xs[i]:
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
