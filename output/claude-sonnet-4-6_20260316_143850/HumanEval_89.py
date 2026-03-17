
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
    for i, c in enumerate(s):
        if c.isalpha():
            if c.islower():
                expected = chr((ord(c) - ord('a') + 4) % 26 + ord('a'))
            else:
                expected = chr((ord(c) - ord('A') + 4) % 26 + ord('A'))
            if output[i] != expected:
                return False
        else:
            if output[i] != c:
                return False
    return True

def _impl(s):
    """Create a function encrypt that takes a string as an argument and
    returns a string encrypted with the alphabet being rotated. 
    The alphabet should be rotated in a manner such that the letters 
    shift down by two multiplied to two places.
    For example:
    encrypt('hi') returns 'lm'
    encrypt('asdfghjkl') returns 'ewhjklnop'
    encrypt('gf') returns 'kj'
    encrypt('et') returns 'ix'"""
    d = 'abcdefghijklmnopqrstuvwxyz'
    return "".join(map(lambda ch: chr((ord(ch) - ord("a") + 4) % 26 + ord("a")) if ch in d else ch, s))

def encrypt(s):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
