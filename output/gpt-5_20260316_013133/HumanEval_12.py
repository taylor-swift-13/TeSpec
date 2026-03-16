from typing import List, Optional

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
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
        return True
    strings = input[0]
    if len(strings) == 0:
        return output is None
    if not isinstance(output, str):
        return False
    max_len = max(len(s) for s in strings)
    # Find first index with max length
    first_idx = None
    for i, s in enumerate(strings):
        if len(s) == max_len:
            first_idx = i
            break
    if first_idx is None:
        return False
    return output == strings[first_idx] and len(output) == max_len

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
