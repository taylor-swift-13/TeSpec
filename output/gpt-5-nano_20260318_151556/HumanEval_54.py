
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    s0, s1 = input
    return isinstance(s0, str) and isinstance(s1, str)

def postcondition(input, output):
    if not precondition(input):
        return False
    s0, s1 = input
    expected = sorted(s0) == sorted(s1)
    return isinstance(output, bool) and output == expected

def _impl(s0: str, s1: str):
    """
    Check if two words have the same characters.
    True
    True
    True
    False
    False
    False
    """
    return set(s0) == set(s1)

def same_chars(s0: str, s1: str):
    _input = (s0, s1)
    assert precondition(_input)
    _output = _impl(s0, s1)
    assert postcondition(_input, _output)
    return _output
