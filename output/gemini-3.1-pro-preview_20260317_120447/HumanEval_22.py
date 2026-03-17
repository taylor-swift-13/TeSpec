from typing import List, Any

def precondition(input: tuple) -> bool:
    if len(input) != 1:
        return False
    values = input[0]
    return isinstance(values, list)

def postcondition(input: tuple, output: list) -> bool:
    if not isinstance(output, list):
        return False
    values = input[0]
    if not all(isinstance(x, int) for x in output):
        return False
    
    it = iter(values)
    for x in output:
        found = False
        for y in it:
            if type(x) is type(y) and x == y:
                found = True
                break
        if not found:
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
