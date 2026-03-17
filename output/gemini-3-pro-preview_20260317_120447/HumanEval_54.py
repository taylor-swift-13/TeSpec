
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 2:
        return False
    s0, s1 = input_args
    return isinstance(s0, str) and isinstance(s1, str)

def postcondition(input_args, output):
    if not isinstance(output, bool):
        return False
    s0, s1 = input_args
    return output == (sorted(s0) == sorted(s1))

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
