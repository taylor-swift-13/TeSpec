
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    if not precondition(input):
        return False
    s = input[0]
    if not isinstance(output, str):
        return False
    if len(output) != len(s):
        return False
    def shift_char(c):
        oc = ord(c)
        if 97 <= oc <= 122:  # a-z
            return chr((oc - 97 + 5) % 26 + 97)
        if 65 <= oc <= 90:   # A-Z
            return chr((oc - 65 + 5) % 26 + 65)
        return c
    for a, b in zip(s, output):
        if b != shift_char(a):
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
