def is_odd(n: int) -> bool:
    return n % 2 != 0

def is_even_pos(i: int) -> bool:
    return i % 2 == 0

def sum_odd_at_even_positions_aux(lst: list, idx: int) -> int:
    if not lst:
        return 0
    x = lst[0]
    xs = lst[1:]
    rest = sum_odd_at_even_positions_aux(xs, idx + 1)
    if is_even_pos(idx) and is_odd(x):
        return x + rest
    else:
        return rest

def sum_odd_at_even_positions(lst: list) -> int:
    return sum_odd_at_even_positions_aux(lst, 0)

def solution_spec(lst: list, result: int) -> bool:
    return result == sum_odd_at_even_positions(lst)

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
