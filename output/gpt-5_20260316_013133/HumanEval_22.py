from typing import List, Any

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    values = input[0]
    if not isinstance(values, list):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    values = input[0]
    if not isinstance(values, list):
        return False
    if not isinstance(output, list):
        return False
    ints_including_bools = [x for x in values if isinstance(x, int)]
    ints_excluding_bools = [x for x in values if type(x) is int]
    return output == ints_including_bools or output == ints_excluding_bools

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
