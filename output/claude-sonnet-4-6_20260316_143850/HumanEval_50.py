
def encode_shift(s: str):
    """
    returns encoded string by shifting every character by 5 in the alphabet.
    """
    return "".join([chr(((ord(ch) + 5 - ord("a")) % 26) + ord("a")) for ch in s])

def precondition(input) -> bool:
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, str):
        return False
    s = input[0]
    if len(output) != len(s):
        return False
    return True

def _impl(s: str):
    """
    takes as input string encoded with encode_shift function. Returns decoded string.
    """
    return "".join([chr((ord(ch) - ord("a") - 5 + 26) % 26 + ord("a")) for ch in s])

def decode_shift(s: str):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
