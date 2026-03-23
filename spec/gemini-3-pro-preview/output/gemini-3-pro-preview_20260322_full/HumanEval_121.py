def sum_odd_at_even_pos(lst):
    res = 0
    for i in range(0, len(lst), 2):
        if lst[i] % 2 != 0:
            res += lst[i]
    return res

def solution_spec(lst, res):
    return res == sum_odd_at_even_pos(lst)

def _impl(lst):
    return sum(lst[i] for i in range(len(lst)) if i % 2 == 0 and lst[i] % 2 == 1)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(solution_spec(*input, output))

def solution(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
