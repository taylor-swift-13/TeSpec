
def precondition(args):
    if len(args) != 2:
        return False
    s0, s1 = args
    if not isinstance(s0, str) or not isinstance(s1, str):
        return False
    return True

def postcondition(args, output):
    if not isinstance(output, bool):
        return False
    s0, s1 = args
    expected = sorted(s0.lower()) == sorted(s1.lower())
    return output == expected

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
