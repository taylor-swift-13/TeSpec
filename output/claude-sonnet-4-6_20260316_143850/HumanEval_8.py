from typing import List, Tuple

def precondition(input) -> bool:
    if len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    for n in numbers:
        if not isinstance(n, int):
            return False
    return True


def postcondition(input, output) -> bool:
    numbers = input[0]
    if not isinstance(output, tuple):
        return False
    if len(output) != 2:
        return False
    s, p = output
    if not isinstance(s, int) or not isinstance(p, int):
        return False
    expected_sum = sum(numbers) if numbers else 0
    expected_product = 1
    for n in numbers:
        expected_product *= n
    if s != expected_sum:
        return False
    if p != expected_product:
        return False
    return True

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
