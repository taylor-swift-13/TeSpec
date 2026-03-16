
def precondition(input):
    s0, s1 = input
    return isinstance(s0, str) and isinstance(s1, str)

def postcondition(input, output):
    s0, s1 = input
    if not isinstance(output, bool):
        return False
    if not precondition(input):
        return True
    # output is True iff s0 and s1 have the same multiset of characters
    # (order doesn't matter, duplicates matter)
    from collections import Counter
    return (output == (Counter(s0) == Counter(s1)))

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
