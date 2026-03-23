def problem_90_pre(l):
    return True

def problem_90_spec(l, res):
    if res is not None:
        z = res
        if not l:
            return False
        s1 = min(l)
        if z not in l:
            return False
        if s1 >= z:
            return False
        for y in l:
            if s1 < y and z > y:
                return False
        return True
    else:
        if not l:
            return True
        first = l[0]
        for x in l:
            if x != first:
                return False
        return True

def _impl(lst):
    if len(lst) <= 1: return None
    sorted_list = sorted(lst)
    for x in sorted_list:
        if x != sorted_list[0]:
            return x

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_90_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_90_spec(*input, output))

def next_smallest(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
