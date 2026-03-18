
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    x = input[0]
    if not isinstance(x, (int, float)):
        return False
    if x <= 0.0:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    x = input[0]
    if not isinstance(x, (int, float)):
        return False
    if x <= 0.0:
        return False
    if not isinstance(output, (int, float)):
        return False
    import math
    expected = x - math.floor(x)
    if abs(output - expected) < 1e-12 and 0.0 <= output < 1.0:
        return True
    return False

def _impl(number: float) -> float:
    """
    Given a positive floating point number, it can be decomposed into
    and integer part (largest integer smaller than given number) and decimals
    (leftover part always smaller than 1).

    Return the decimal part of the number.
    0.5
    """
    return number - int(number)

def truncate_number(number: float) -> float:
    _input = (number,)
    assert precondition(_input)
    _output = _impl(number)
    assert postcondition(_input, _output)
    return _output
