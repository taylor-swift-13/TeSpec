import math

def truncate_number_spec(number, result):
    if number <= 0:
        return False
    int_part = math.floor(number)
    expected_result = number - int_part
    return result == expected_result and 0 <= result < 1

def _impl(number: float) -> float:
    return number - int(number)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(truncate_number_spec(*input, output))

def truncate_number(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
