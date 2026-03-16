
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    xs = input[0]
    if not isinstance(xs, list):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    xs = input[0]
    if not isinstance(output, list):
        return False
    expected_len = len(xs) - 1
    if expected_len < 0:
        expected_len = 0
    if len(output) != expected_len:
        return False
    for j in range(len(output)):
        try:
            expected = (j + 1) * xs[j + 1]
        except Exception:
            return False
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
