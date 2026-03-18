from typing import List, Tuple

def precondition(input):
    # input is a tuple of positional arguments
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    for x in numbers:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    # Validate input first
    if not precondition(input):
        return False
    numbers = input[0]
    expected_sum = 0
    expected_prod = 1
    for x in numbers:
        expected_sum += x
        expected_prod *= x
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    s, p = output
    if not isinstance(s, int) or not isinstance(p, int):
        return False
    return s == expected_sum and p == expected_prod

def _impl(numbers: List[int]) -> Tuple[int, int]:
    """
    For a given list of integers, return a tuple consisting of a sum and a product of all the integers in a list.
    Empty sum should be equal to 0 and empty product should be equal to 1.
    (0, 1)
    (10, 24)
    """
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
