
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    number = input[0]
    if not isinstance(number, float):
        return False
    if number <= 0.0:
        return False
    if number != number:  # NaN
        return False
    if number == float('inf') or number == float('-inf'):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    number = input[0]
    if not isinstance(number, float):
        return False
    if number <= 0.0:
        return False
    if number != number or number == float('inf') or number == float('-inf'):
        return False
    try:
        out_val = float(output)
    except Exception:
        return False
    expected = number - int(number)  # decimal part
    return abs(out_val - expected) <= 1e-9

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
