from typing import List, Tuple

def precondition(args):
    if len(args) != 1:
        return False
    numbers = args[0]
    return isinstance(numbers, list) and all(isinstance(x, int) for x in numbers)

def postcondition(args, out):
    numbers = args[0]
    if not isinstance(out, tuple) or len(out) != 2:
        return False
    if not isinstance(out[0], int) or not isinstance(out[1], int):
        return False
    expected_sum = sum(numbers)
    expected_prod = 1
    for x in numbers:
        expected_prod *= x
    return out[0] == expected_sum and out[1] == expected_prod

def _impl(numbers: List[int]) -> Tuple[int, int]:
    """For a given list of integers, return a tuple consisting of a sum and a product of all the integers in a list.
    Empty sum should be equal to 0 and empty product should be equal to 1.
    (0, 1)
    (10, 24)"""
    s, p = 0, 1
    for number in numbers:
        s += number
        p *= number
    return s, p

def sum_product(numbers: List[int]) -> Tuple[int, int]:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
