
def precondition(input):
    (number,) = input
    # Check that number is a float and is positive
    if not isinstance(number, float):
        return False
    if number <= 0:
        return False
    return True

def postcondition(input, output):
    (number,) = input
    # Output should be a float
    if not isinstance(output, float):
        return False
    # Decimal part should be >= 0 and < 1
    if output < 0 or output >= 1:
        return False
    # The decimal part plus the integer part should equal the original number
    integer_part = int(number)
    if abs((integer_part + output) - number) > 1e-9:
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
