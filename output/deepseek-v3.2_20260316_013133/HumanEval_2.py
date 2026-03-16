
def precondition(input):
    number = input[0]
    return isinstance(number, (int, float)) and number >= 0

def postcondition(input, output):
    number = input[0]
    if not isinstance(output, (int, float)):
        return False
    integer_part = int(number)
    expected_decimal = number - integer_part
    return abs(output - expected_decimal) < 1e-12 and 0 <= output < 1

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
