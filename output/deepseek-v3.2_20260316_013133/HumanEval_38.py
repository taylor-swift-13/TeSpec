
def precondition(input):
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    s = input[0]
    return isinstance(output, str) and len(output) == len(s)

def _impl(s: str):
    """takes as input string encoded with encode_cyclic function. Returns decoded string.
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
