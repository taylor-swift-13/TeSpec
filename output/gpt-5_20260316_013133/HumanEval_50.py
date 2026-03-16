
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    return isinstance(input[0], str)

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    if not isinstance(output, str):
        return False
    if len(output) != len(s):
        return False
    for i, ch in enumerate(s):
        oc = output[i]
        o = ord(ch)
        if 97 <= o <= 122:
            expected = chr(((o - 97 + 5) % 26) + 97)
            if oc != expected:
                return False
        elif 65 <= o <= 90:
            expected = chr(((o - 65 + 5) % 26) + 65)
            if oc != expected:
                return False
    return True

def _impl(s: str):
    """returns encoded string by shifting every character by 5 in the alphabet."""
    return "".join([chr((ord(ch) - ord("a") - 5 + 26) % 26 + ord("a")) for ch in s])

def encode_shift(s: str):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
