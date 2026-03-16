from typing import List, Optional

def precondition(input):
    strings, = input
    return isinstance(strings, list) and all(isinstance(s, str) for s in strings)

def postcondition(input, output):
    strings, = input
    if not precondition(input):
        return False
    if not strings:
        return output is None
    if output is None:
        return False
    if not isinstance(output, str):
        return False
    if output not in strings:
        return False
    max_len = max(len(s) for s in strings)
    if len(output) != max_len:
        return False
    first_max_index = next(i for i, s in enumerate(strings) if len(s) == max_len)
    return strings[first_max_index] == output

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
