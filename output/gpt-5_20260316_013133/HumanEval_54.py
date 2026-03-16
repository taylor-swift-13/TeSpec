
from collections import Counter

def precondition(input):
    return isinstance(input, tuple) and len(input) == 2 and isinstance(input[0], str) and isinstance(input[1], str)

def postcondition(input, output):
    if not precondition(input):
        return False
    if not isinstance(output, bool):
        return False
    s0, s1 = input
    return output == (Counter(s0) == Counter(s1))

def _impl(s0: str, s1: str):
    """Check if two words have the same characters.
    True
    True
    True
    False
    False
    False"""
    return set(s0) == set(s1)

def same_chars(s0: str, s1: str):
    _input = (s0, s1)
    assert precondition(_input)
    _output = _impl(s0, s1)
    assert postcondition(_input, _output)
    return _output
