from typing import List, Any

def precondition(input) -> bool:
    values = input[0]
    return isinstance(values, list)

def postcondition(input, output) -> bool:
    values = input[0]
    if not isinstance(output, list):
        return False
    for item in output:
        if not isinstance(item, int) or isinstance(item, bool):
            return False
    for item in output:
        if item not in values:
            return False
    count = sum(1 for item in values if isinstance(item, int) and not isinstance(item, bool))
    if len(output) != count:
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
