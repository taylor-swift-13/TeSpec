from typing import List, Optional

def precondition(inputs: tuple) -> bool:
    if len(inputs) != 1:
        return False
    strings = inputs[0]
    if not isinstance(strings, list):
        return False
    return all(isinstance(s, str) for s in strings)

def postcondition(inputs: tuple, output) -> bool:
    strings = inputs[0]
    if not strings:
        return output is None
    max_len = max(len(s) for s in strings)
    for s in strings:
        if len(s) == max_len:
            return output == s
    return False

def _impl(strings: List[str]) -> Optional[str]:
    """Out of list of strings, return the longest one. Return the first one in case of multiple
    strings of the same length. Return None in case the input list is empty.

    'a'
    'ccc'"""
    if not strings:
        return None

    maxlen = max(len(x) for x in strings)
    for s in strings:
        if len(s) == maxlen:
            return s

def longest(strings: List[str]) -> Optional[str]:
    _input = (strings,)
    assert precondition(_input)
    _output = _impl(strings)
    assert postcondition(_input, _output)
    return _output
