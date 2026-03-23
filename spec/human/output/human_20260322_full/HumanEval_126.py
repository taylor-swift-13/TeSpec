def problem_126_pre(l):
    return True

def problem_126_spec(l, b):
    is_sorted = all(l[i] < l[i+1] for i in range(len(l) - 1))
    return b == is_sorted

def _impl(lst):
    count = dict()
    for x in lst:
        if x not in count: count[x] = 0
        count[x] += 1
        if count[x] > 2: return False
    return lst == sorted(lst)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_126_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_126_spec(*input, output))

def is_sorted(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
