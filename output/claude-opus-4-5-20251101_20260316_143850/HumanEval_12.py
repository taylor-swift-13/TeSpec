from typing import List, Optional

def precondition(input):
    strings = input[0]
    # Check that strings is a list
    if not isinstance(strings, list):
        return False
    # Check that all elements are strings
    for s in strings:
        if not isinstance(s, str):
            return False
    return True

def postcondition(input, output):
    strings = input[0]
    
    # If the list is empty, output should be None
    if len(strings) == 0:
        return output is None
    
    # Output should be a string from the list
    if not isinstance(output, str):
        return False
    
    # Output should be in the list
    if output not in strings:
        return False
    
    # Output should have the maximum length
    max_len = max(len(s) for s in strings)
    if len(output) != max_len:
        return False
    
    # Output should be the first string with maximum length
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
