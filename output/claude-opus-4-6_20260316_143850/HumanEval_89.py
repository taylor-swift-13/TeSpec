
def precondition(input):
    (s,) = input
    if not isinstance(s, str):
        return False
    return True


def postcondition(input, output):
    (s,) = input
    if not isinstance(output, str):
        return False
    if len(output) != len(s):
        return False
    # Verify the rotation logic: each letter shifts by 2*2=4 positions
    for i, ch in enumerate(s):
        if ch.isalpha():
            if ch.islower():
                expected = chr((ord(ch) - ord('a') + 4) % 26 + ord('a'))
            else:
                expected = chr((ord(ch) - ord('A') + 4) % 26 + ord('A'))
            if output[i] != expected:
                return False
        else:
            if output[i] != ch:
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
