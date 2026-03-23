def is_even(n):
    return n % 2 == 0

def is_odd_index(i):
    return i % 2 != 0

def add_even_at_odd_indices_aux(lst, idx):
    if not lst:
        return 0
    x = lst[0]
    xs = lst[1:]
    rest = add_even_at_odd_indices_aux(xs, idx + 1)
    if is_odd_index(idx) and is_even(x):
        return x + rest
    else:
        return rest

def add_even_at_odd_indices(lst):
    return add_even_at_odd_indices_aux(lst, 0)

def add_spec(lst, result):
    return result == add_even_at_odd_indices(lst)

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
