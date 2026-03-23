def sum_even_at_odd_from(i, l):
    total = 0
    for idx, x in enumerate(l):
        if (i + idx) % 2 != 0 and x % 2 == 0:
            total += x
    return total

def sum_even_at_odd(l):
    return sum_even_at_odd_from(0, l)

def add_spec(lst, s):
    return s == sum_even_at_odd(lst)

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
