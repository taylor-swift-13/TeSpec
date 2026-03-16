from typing import List, Tuple

def precondition(input):
    numbers, = input
    return isinstance(numbers, list) and all(isinstance(x, int) for x in numbers)

def postcondition(input, output):
    numbers, = input
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    s, p = output
    if not isinstance(s, int) or not isinstance(p, int):
        return False
    if len(numbers) == 0:
        return s == 0 and p == 1
    # sum check
    if sum(numbers) != s:
        return False
    # product check
    prod = 1
    for n in numbers:
        prod *= n
    return prod == p

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
