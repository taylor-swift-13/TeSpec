from typing import List, Optional

def precondition(input):
    strings = input[0]
    return isinstance(strings, list) and all(isinstance(s, str) for s in strings)

def postcondition(input, output):
    strings = input[0]
    if not strings:
        return output is None
    
    expected = max(strings, key=lambda s: (len(s), -strings.index(s)))
    return output == expected

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
