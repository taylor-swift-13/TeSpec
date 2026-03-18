from typing import List

def precondition(input):
    # input is a tuple of positional arguments
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    strings = input[0]
    if not isinstance(strings, list):
        return False
    for s in strings:
        if not isinstance(s, str):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    strings = input[0]
    expected = ''.join(strings)
    if not isinstance(output, str):
        return False
    return output == expected

def _impl(strings: List[str]) -> str:
    """
    Concatenate list of strings into a single string
    ''
    'abc'
    """
    return "".join(strings)

def concatenate(strings: List[str]) -> str:
    _input = (strings,)
    assert precondition(_input)
    _output = _impl(strings)
    assert postcondition(_input, _output)
    return _output
