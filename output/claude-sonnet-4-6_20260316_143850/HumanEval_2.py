
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    number = input[0]
    if not isinstance(number, (int, float)):
        return False
    if number <= 0:
        return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, float):
        return False
    if output < 0 or output >= 1:
        return False
    number = input[0]
    import math
    expected = number - math.floor(number)
    if abs(output - expected) > 1e-9:
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
