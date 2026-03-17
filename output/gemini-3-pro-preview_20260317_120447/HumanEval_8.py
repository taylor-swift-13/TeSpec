from typing import List, Tuple

def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 1:
        return False
    numbers = input_args[0]
    return isinstance(numbers, list) and all(isinstance(x, int) for x in numbers)

def postcondition(input_args, output):
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    numbers = input_args[0]
    
    expected_sum = 0
    for x in numbers:
        expected_sum += x
        
    expected_prod = 1
    for x in numbers:
        expected_prod *= x
        
    return output[0] == expected_sum and output[1] == expected_prod

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
