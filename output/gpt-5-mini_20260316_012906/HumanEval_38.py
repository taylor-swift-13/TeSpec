
def precondition(input):
    try:
        return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)
    except Exception:
        return False

def postcondition(input, output):
    try:
        if not (isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)):
            return False
        s = input[0]
        if not isinstance(output, str):
            return False
        if len(output) != len(s):
            return False
        # Output should be a permutation of the input characters (cycling groups of three permutes characters)
        return sorted(output) == sorted(s)
    except Exception:
        return False

def _impl(s: str):
    """returns encoded string by cycling groups of three characters."""
    groups = [s[(3 * i):min((3 * i + 3), len(s))] for i in range((len(s) + 2) // 3)]
    groups = [(group[2] + group[:2]) if len(group) == 3 else group for group in groups]
    return "".join(groups)

def encode_cyclic(s: str):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
