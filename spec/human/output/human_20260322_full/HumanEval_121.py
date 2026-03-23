import sys
sys.setrecursionlimit(2000)

def sum_odd_in_even_pos_aux(l, idx):
    if not l:
        return 0
    h = l[0]
    t = l[1:]
    val = h if (idx % 2 == 0) and (h % 2 != 0) else 0
    return val + sum_odd_in_even_pos_aux(t, idx + 1)

def sum_odd_in_even_pos_impl(l):
    return sum_odd_in_even_pos_aux(l, 0)

def problem_121_pre(l):
    return len(l) > 0

def problem_121_spec(l, output):
    return output == sum_odd_in_even_pos_impl(l)

def _impl(lst):
    return sum(lst[i] for i in range(len(lst)) if i % 2 == 0 and lst[i] % 2 == 1)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_121_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_121_spec(*input, output))

def solution(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
