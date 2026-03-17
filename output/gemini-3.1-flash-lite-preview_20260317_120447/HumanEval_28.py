from typing import List

def precondition(input):
    strings = input[0]
    return isinstance(strings, list) and all(isinstance(s, str) for s in strings)

def postcondition(input, output):
    strings = input[0]
    return isinstance(output, str) and output == "".join(strings)

def _impl(strings: List[str]) -> str:
    """Concatenate list of strings into a single string
    ''
    'abc'"""
    return "".join(strings)

def concatenate(strings: List[str]) -> str:
    _input = (strings,)
    assert precondition(_input)
    _output = _impl(strings)
    assert postcondition(_input, _output)
    return _output
