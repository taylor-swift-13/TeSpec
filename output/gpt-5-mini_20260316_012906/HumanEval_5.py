from typing import List

def precondition(input):
    # input is expected to be a tuple (numbers, delimeter)
    try:
        if not isinstance(input, tuple):
            return False
        if len(input) != 2:
            return False
        numbers, delimeter = input
        if not isinstance(numbers, list):
            return False
        if not isinstance(delimeter, int):
            return False
        for x in numbers:
            if not isinstance(x, int):
                return False
        return True
    except Exception:
        return False

def postcondition(input, output):
    # If precondition failed, do not enforce postcondition here
    try:
        if not precondition(input):
            return True
        numbers, delimeter = input
        if not isinstance(output, list):
            return False
        n = len(numbers)
        # For empty input list, output should be empty list
        if n == 0:
            return output == []
        # For n >= 1, length must be 2*n - 1
        if len(output) != 2 * n - 1:
            return False
        # All output elements should be ints
        for y in output:
            if not isinstance(y, int):
                return False
        # Check elements: numbers at even positions, delimiter at odd positions
        for i in range(n):
            if output[2 * i] != numbers[i]:
                return False
            if i < n - 1:
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
