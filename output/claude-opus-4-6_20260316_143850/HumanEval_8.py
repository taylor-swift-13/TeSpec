from typing import List, Tuple

def precondition(input):
    try:
        (numbers,) = input
        if not isinstance(numbers, list):
            return False
        for n in numbers:
            if not isinstance(n, int):
                return False
        return True
    except Exception:
        return False


def postcondition(input, output):
    try:
        (numbers,) = input
        if not isinstance(output, tuple) or len(output) != 2:
            return False
        s, p = output
        # Check sum
        expected_sum = sum(numbers)
        if s != expected_sum:
            return False
        # Check product
        expected_product = 1
        for n in numbers:
            expected_product *= n
        if p != expected_product:
            return False
        return True
    except Exception:
        return False

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
