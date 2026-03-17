from typing import List, Any

def precondition(input):
    values = input[0]
    # values must be a list
    if not isinstance(values, list):
        return False
    return True


def postcondition(input, output):
    values = input[0]
    # output must be a list
    if not isinstance(output, list):
        return False
    # every element in output must be an integer (and not bool, since bool is subclass of int)
    for v in output:
        if not isinstance(v, int) or isinstance(v, bool):
            return False
    # all integers (non-bool) from the input must appear in the output
    input_ints = [v for v in values if isinstance(v, int) and not isinstance(v, bool)]
    if len(output) != len(input_ints):
        return False
    # output should preserve order and values from input
    idx = 0
    for v in values:
        if isinstance(v, int) and not isinstance(v, bool):
            if idx >= len(output) or output[idx] != v:
                return False
            idx += 1
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
