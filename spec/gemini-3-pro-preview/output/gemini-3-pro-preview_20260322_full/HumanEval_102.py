def choose_num_spec(x: int, y: int, result: int) -> bool:
    if x > y:
        expected = -1
    elif y % 2 == 0:
        expected = y
    elif y - 1 >= x:
        expected = y - 1
    else:
        expected = -1
    return result == expected

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
