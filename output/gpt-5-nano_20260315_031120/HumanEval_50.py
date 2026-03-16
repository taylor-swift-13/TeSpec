
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    if not isinstance(output, str):
        return False
    s = input[0]
    if not isinstance(s, str):
        return False

    res = []
    for ch in s:
        if 'a' <= ch <= 'z':
            res.append(chr(ord('a') + (ord(ch) - ord('a') + 5) % 26))
        elif 'A' <= ch <= 'Z':
            res.append(chr(ord('A') + (ord(ch) - ord('A') + 5) % 26))
        else:
            res.append(ch)
    expected = ''.join(res)
    return output == expected

def _impl(s: str):
    """returns encoded string by shifting every character by 5 in the alphabet."""
    return "".join([chr((ord(ch) - ord("a") - 5 + 26) % 26 + ord("a")) for ch in s])

def encode_shift(s: str):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
