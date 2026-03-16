from typing import List, Any

def precondition(input) -> bool:
    # Expect a single positional argument which is a list (values)
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    values = input[0]
    return isinstance(values, list)

def postcondition(input, output) -> bool:
    # Require precondition to hold
    if not precondition(input):
        return False
    values = input[0]
    # output must be a list of integers (using isinstance to allow int subclasses)
    if not isinstance(output, list):
        return False
    for item in output:
        if not isinstance(item, int):
            return False
    # Expected filtered list: keep elements that are ints in original order
    expected = [x for x in values if isinstance(x, int)]
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
