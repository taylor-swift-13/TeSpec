from typing import List, Any

def precondition(input):
    values, = input
    return isinstance(values, list)

def postcondition(input, output):
    values, = input
    if not isinstance(output, list):
        return False
    if not all(isinstance(x, int) for x in output):
        return False
    if not all(x in values for x in output):
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
