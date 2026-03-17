
def precondition(input) -> bool:
    try:
        xs = input[0]
        if not isinstance(xs, list):
            return False
        for x in xs:
            if not isinstance(x, (int, float)):
                return False
        return True
    except Exception:
        return False


def postcondition(input, output) -> bool:
    try:
        xs = input[0]
        if not isinstance(output, list):
            return False
        expected_len = max(0, len(xs) - 1)
        if len(output) != expected_len:
            return False
        for i, coef in enumerate(output):
            if not isinstance(coef, (int, float)):
                return False
            expected = (i + 1) * xs[i + 1]
            if abs(coef - expected) > 1e-9:
                return False
        return True
    except Exception:
        return False

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
