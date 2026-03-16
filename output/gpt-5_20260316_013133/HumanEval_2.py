
def precondition(input):
    import math
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    x = input[0]
    if isinstance(x, bool):
        return False
    if not isinstance(x, (int, float)):
        return False
    if isinstance(x, float) and not math.isfinite(x):
        return False
    return x >= 0


def postcondition(input, output):
    import math
    if not precondition(input):
        return True
    x = input[0]
    if isinstance(output, bool):
        return False
    if not isinstance(output, (int, float)):
        return False
    floor_val = math.floor(x)
    expected = x - floor_val
    out = float(output)
    tol = 1e-12
    if out < -tol or out > 1 + tol:
        return False
    return abs(out - expected) <= tol

def _impl(number: float) -> float:
    """Given a positive floating point number, it can be decomposed into
    and integer part (largest integer smaller than given number) and decimals
    (leftover part always smaller than 1).

    Return the decimal part of the number.
    0.5"""
    return number - int(number)

def truncate_number(number: float) -> float:
    _input = (number,)
    assert precondition(_input)
    _output = _impl(number)
    assert postcondition(_input, _output)
    return _output
