from typing import List, Any

def precondition(input):
    values = input[0]
    return isinstance(values, list)

def postcondition(input, output):
    return isinstance(output, list) and all(isinstance(x, int) for x in output)

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
