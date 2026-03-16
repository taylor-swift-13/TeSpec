
def precondition(input):
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    s = input[0]
    if not isinstance(output, str):
        return False
    if len(s) != len(output):
        return False
    for c1, c2 in zip(s, output):
        if not ('a' <= c1 <= 'z' or 'A' <= c1 <= 'Z'):
            if c1 != c2:
                return False
        else:
            base = ord('a') if 'a' <= c1 <= 'z' else ord('A')
            expected = chr((ord(c1) - base + 5) % 26 + base)
            if c2 != expected:
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
