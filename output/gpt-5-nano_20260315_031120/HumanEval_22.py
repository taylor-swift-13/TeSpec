from typing import List, Any

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    values = input[0]
    if not isinstance(values, list):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    if not isinstance(output, list):
        return False
    values = input[0]
    if not isinstance(values, list):
        return False
    expected = [x for x in values if type(x) is int]
    return output == expected

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
