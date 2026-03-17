
def precondition(input):
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    s = input[0]
    if not isinstance(output, str):
        return False
    # The decoded output should have the same length as the input
    if len(output) != len(s):
        return False
    # Encoding the output should give back the input (encode_cyclic is its own inverse when applied twice)
    # We replicate encode_cyclic here to verify the round-trip property
    def encode_cyclic(s):
        groups = [s[(3 * i):min((3 * i + 3), len(s))] for i in range((len(s) + 2) // 3)]
        groups = [(group[1:] + group[0]) if len(group) == 3 else group for group in groups]
        return "".join(groups)
    # decode(encode(x)) == x, so encode(output) should equal s
    if encode_cyclic(output) != s:
        return False
    return True

def _impl(s: str):
    """takes as input string encoded with encode_cyclic function. Returns decoded string."""
    groups = [s[(3 * i):min((3 * i + 3), len(s))] for i in range((len(s) + 2) // 3)]
    groups = [(group[2] + group[:2]) if len(group) == 3 else group for group in groups]
    return "".join(groups)

def decode_cyclic(s: str):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
