from typing import List, Tuple

def precondition(input):
    numbers = input[0]
    return isinstance(numbers, list) and all(isinstance(x, int) for x in numbers)

def postcondition(input, output):
    numbers = input[0]
    s, p = output
    
    expected_sum = sum(numbers)
    expected_prod = 1
    for n in numbers:
        expected_prod *= n
        
    return s == expected_sum and p == expected_prod

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
