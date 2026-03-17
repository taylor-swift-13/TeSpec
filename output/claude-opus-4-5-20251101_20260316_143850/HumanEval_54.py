
def precondition(input):
    if len(input) != 2:
        return False
    s0, s1 = input
    if not isinstance(s0, str) or not isinstance(s1, str):
        return False
    return True

def postcondition(input, output):
    s0, s1 = input
    if not isinstance(output, bool):
        return False
    # Check that output correctly indicates whether s0 and s1 have the same characters
    same_chars = set(s0) == set(s1)
    return output == same_chars

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
