def is_min_of_list(m, l):
    return (m in l) and all(m <= x for x in l)

def next_smallest_spec(lst, r):
    if r is None:
        if not lst:
            return True
        m = min(lst)
        return all(x == m for x in lst)
    else:
        if not lst:
            return False
        m = min(lst)
        return (r in lst) and (m < r) and all(r <= y for y in lst if m < y)

def _impl(lst):
    if len(lst) <= 1: return None
    sorted_list = sorted(lst)
    for x in sorted_list:
        if x != sorted_list[0]:
            return x

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(next_smallest_spec(*input, output))

def next_smallest(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
