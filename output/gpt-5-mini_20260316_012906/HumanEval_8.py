from typing import List, Tuple

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    nums = input[0]
    if not isinstance(nums, (list, tuple)):
        return False
    for x in nums:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    nums = input[0]
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    s, p = output
    if not isinstance(s, int) or isinstance(s, bool):
        return False
    if not isinstance(p, int) or isinstance(p, bool):
        return False
    exp_s = 0
    exp_p = 1
    for x in nums:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
        exp_s += x
        exp_p *= x
    return s == exp_s and p == exp_p

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
