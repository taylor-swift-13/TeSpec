from typing import List

def precondition(input):
    strings, = input
    return isinstance(strings, list) and all(isinstance(s, str) for s in strings)

def postcondition(input, output):
    strings, = input
    if not precondition(input):
        return False
    if not isinstance(output, str):
        return False
    # Check that output length equals sum of input string lengths
    total_length = sum(len(s) for s in strings)
    if len(output) != total_length:
        return False
    # Check that output contains all input strings in order
    idx = 0
    for s in strings:
        if output[idx:idx+len(s)] != s:
            return False
        idx += len(s)
    return True

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
