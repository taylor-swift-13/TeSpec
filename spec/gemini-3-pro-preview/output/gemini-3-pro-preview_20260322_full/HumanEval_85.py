def add_sum(lst, is_odd_idx):
    total = 0
    for x in lst:
        if is_odd_idx and x % 2 == 0:
            total += x
        is_odd_idx = not is_odd_idx
    return total

def add_spec(lst, res):
    return res == add_sum(lst, False)

def _impl(lst):
    s = 0
    for i in range(1, len(lst), 2):
        if lst[i] % 2 == 0:
            s += lst[i]
    return s

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(add_spec(*input, output))

def add(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
