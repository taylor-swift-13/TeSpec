def is_equal_to_sum_even_spec(n: int, res: bool) -> bool:
    return res == ((n >= 8) and (n % 2 == 0))

def _impl(n):
    return n >= 8 and n % 2 == 0

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_equal_to_sum_even_spec(*input, output))

def is_equal_to_sum_even(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
