from typing import List

def precondition(input):
    try:
        numbers, delimeter = input
        if not isinstance(numbers, list):
            return False
        if not isinstance(delimeter, int):
            return False
        if not all(isinstance(n, int) for n in numbers):
            return False
        return True
    except Exception:
        return False


def postcondition(input, output):
    try:
        numbers, delimeter = input
        if not isinstance(output, list):
            return False
        
        # Empty list should return empty list
        if len(numbers) == 0:
            return output == []
        
        # Single element list should return single element list
        if len(numbers) == 1:
            return output == [numbers[0]]
        
        # Expected length: n elements + (n-1) delimiters = 2n - 1
        n = len(numbers)
        if len(output) != 2 * n - 1:
            return False
        
        # Check that elements at even indices are the original numbers in order
        for i in range(n):
            if output[2 * i] != numbers[i]:
                return False
        
        # Check that elements at odd indices are the delimiter
        for i in range(n - 1):
            if output[2 * i + 1] != delimeter:
                return False
        
        return True
    except Exception:
        return False

def _impl(numbers: List[int], delimeter: int) -> List[int]:
    """Insert a number 'delimeter' between every two consecutive elements of input list `numbers'
    []
    [1, 4, 2, 4, 3]"""
    res = []
    for i in range(len(numbers)):
        res.append(numbers[i])
        if i != len(numbers) - 1:
            res.append(delimeter)
    return res

def intersperse(numbers: List[int], delimeter: int) -> List[int]:
    _input = (numbers, delimeter)
    assert precondition(_input)
    _output = _impl(numbers, delimeter)
    assert postcondition(_input, _output)
    return _output
