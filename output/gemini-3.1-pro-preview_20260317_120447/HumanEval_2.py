
def precondition(inputs: tuple) -> bool:
    if len(inputs) != 1:
        return False
    number = inputs[0]
    if not isinstance(number, (int, float)):
        return False
    if not (0 < number < float('inf')):
        return False
    return True

def postcondition(inputs: tuple, output) -> bool:
    number = inputs[0]
    if not isinstance(output, (int, float)):
        return False
    if not (0.0 <= output < 1.0):
        return False
    expected = number - int(number)
    if abs(output - expected) > 1e-5:
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
