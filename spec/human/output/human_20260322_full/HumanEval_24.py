def problem_24_pre(input: int) -> bool:
    return input >= 2

def problem_24_spec(input: int, output: int) -> bool:
    if input < 0 or output < 0:
        return False
    if output == 0:
        return False
    if input % output != 0:
        return False
    if not (output < input):
        return False
    for i in range(1, input):
        if input % i == 0:
            if i > output:
                return False
    return True

def _impl(n: int) -> int:
    for i in range(2, n):
        if n % i == 0: return n // i
    return 1

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_24_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_24_spec(*input, output))

def largest_divisor(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
