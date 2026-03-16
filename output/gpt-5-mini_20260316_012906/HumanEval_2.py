
import math

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    x = input[0]
    # reject booleans
    if isinstance(x, bool):
        return False
    if not isinstance(x, (int, float)):
        return False
    try:
        xf = float(x)
    except Exception:
        return False
    if not math.isfinite(xf):
        return False
    # require positive (strictly greater than 0)
    if not (xf > 0):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    x = float(input[0])
    # expected fractional part = x - floor(x) for non-negative x
    expected = x - math.floor(x)
    # output must be a numeric (not bool) and finite
    if isinstance(output, bool):
        return False
    if not isinstance(output, (int, float)):
        return False
    try:
        of = float(output)
    except Exception:
        return False
    if not math.isfinite(of):
        return False
    # output should be close to expected fractional part
    if not math.isclose(of, expected, rel_tol=1e-9, abs_tol=1e-12):
        return False
    # and be in [0,1)
    if not (-1e-12 <= of < 1 - 1e-12 or math.isclose(of, 0.0, abs_tol=1e-12)):
        return False
    return True

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
