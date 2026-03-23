from typing import List, Tuple

def problem_8_pre():
    return True

def problem_8_spec(l, s, p):
    sum_val = sum(l)
    prod_val = 1
    for x in l:
        prod_val *= x
    return s == sum_val and p == prod_val

def _impl(numbers: List[int]) -> Tuple[int, int]:
    s, p = 0, 1
    for number in numbers:
        s += number
        p *= number
    return s, p

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_8_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_8_spec(*input, output))

def sum_product(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
