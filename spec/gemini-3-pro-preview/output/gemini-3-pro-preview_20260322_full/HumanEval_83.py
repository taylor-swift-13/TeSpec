def starts_one_ends_spec(n: int, result: int) -> bool:
    if n == 1:
        expected = 1
    else:
        pow_val = 0 if n - 2 < 0 else 10 ** (n - 2)
        expected = 18 * pow_val
    return result == expected

def _impl(n):
    if n == 1: return 1
    return 18 * 10 ** (n - 2)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(starts_one_ends_spec(*input, output))

def starts_one_ends(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
