from typing import List, Any

def precondition(input: tuple) -> bool:
    # Check that input is a tuple with exactly one element
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    
    values = input[0]
    
    # Check that values is a list
    if not isinstance(values, list):
        return False
    
    return True


def postcondition(input: tuple, output) -> bool:
    values = input[0]
    
    # Check that output is a list
    if not isinstance(output, list):
        return False
    
    # Check that all elements in output are integers (but not bools)
    for item in output:
        if type(item) is not int:
            return False
    
    # Check that output contains exactly the integers from input (preserving order)
    expected = [x for x in values if type(x) is int]
    if output != expected:
        return False
    
    return True

def _impl(values: List[Any]) -> List[int]:
    """Filter given list of any python values only for integers
    [5]
    [1, 2, 3]"""
    return list(filter(lambda x: type(x) == int, values))

def filter_integers(values: List[Any]) -> List[int]:
    _input = (values,)
    assert precondition(_input)
    _output = _impl(values)
    assert postcondition(_input, _output)
    return _output
