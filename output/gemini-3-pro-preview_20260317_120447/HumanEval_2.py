
def precondition(input_args):
    return len(input_args) == 1 and isinstance(input_args[0], (float, int)) and input_args[0] > 0

def postcondition(input_args, output):
    import math
    number = input_args[0]
    if not (isinstance(output, (float, int)) and 0 <= output < 1):
        return False
    return math.isclose(output, number - math.floor(number), rel_tol=1e-9, abs_tol=1e-9)

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
