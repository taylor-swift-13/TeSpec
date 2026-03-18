
def encode_cyclic(s: str):
    """
    returns encoded string by cycling groups of three characters.
    """
    # split string to groups. Each of length 3.
    groups = [s[(3 * i):min((3 * i + 3), len(s))] for i in range((len(s) + 2) // 3)]
    # cycle elements in each group. Unless group has fewer elements than 3.
    groups = [(group[1:] + group[0]) if len(group) == 3 else group for group in groups]
    return "".join(groups)

def precondition(args):
    return isinstance(args[0], str)

def postcondition(args, output):
    if not isinstance(output, str):
        return False
    s = args[0]
    if len(s) != len(output):
        return False
    groups = [output[(3 * i):min((3 * i + 3), len(output))] for i in range((len(output) + 2) // 3)]
    encoded = "".join([(group[1:] + group[0]) if len(group) == 3 else group for group in groups])
    return encoded == s

def _impl(s: str):
    """
    takes as input string encoded with encode_cyclic function. Returns decoded string.
    """
    groups = [s[(3 * i):min((3 * i + 3), len(s))] for i in range((len(s) + 2) // 3)]
    groups = [(group[2] + group[:2]) if len(group) == 3 else group for group in groups]
    return "".join(groups)

def decode_cyclic(s: str):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
