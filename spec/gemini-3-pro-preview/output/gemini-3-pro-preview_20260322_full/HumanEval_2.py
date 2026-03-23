import math

def truncate_number_spec(number, result):
    if not (number >= 0):
        return True
    
    # exists i : Z, IZR i <= number < IZR i + 1
    # This uniquely defines i as the floor of number.
    i = math.floor(number)
    
    # result = number - IZR i
    return result == number - i

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
