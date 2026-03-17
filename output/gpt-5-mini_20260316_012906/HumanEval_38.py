
def precondition(input):
    try:
        if not isinstance(input, tuple):
            return False
        if len(input) != 1:
            return False
        s = input[0]
        return isinstance(s, str)
    except Exception:
        return False

def postcondition(input, output):
    try:
        if not precondition(input):
            return False
        if not isinstance(output, str):
            return False
        s = input[0]
        # Decoded output should have same length as the encoded input.
        if len(output) != len(s):
            return False
        # If input was empty, output must be empty.
        if s == "" and output != "":
            return False
        return True
    except Exception:
        return False

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
