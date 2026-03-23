def choose_num_spec(x: int, y: int, r: int) -> bool:
    if x > y:
        return r == -1
    else:
        max_even = y if y % 2 == 0 else y - 1
        if max_even >= x:
            return r == max_even
        else:
            return r == -1

def _impl(x, y):
    if x > y: return -1
    if x == y: return y if y % 2 == 0 else -1
    return y if y % 2 == 0 else y - 1

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(choose_num_spec(*input, output))

def choose_num(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
