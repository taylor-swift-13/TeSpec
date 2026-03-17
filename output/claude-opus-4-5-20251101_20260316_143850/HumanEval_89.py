
def precondition(args: tuple) -> bool:
    (s,) = args
    # Input must be a string
    if not isinstance(s, str):
        return False
    # All characters must be lowercase letters (based on examples)
    for c in s:
        if not ('a' <= c <= 'z'):
            return False
    return True

def postcondition(args: tuple, output) -> bool:
    (s,) = args
    # Output must be a string
    if not isinstance(output, str):
        return False
    # Output must have the same length as input
    if len(output) != len(s):
        return False
    # All output characters must be lowercase letters
    for c in output:
        if not ('a' <= c <= 'z'):
            return False
    # Each character should be shifted by 2*2=4 positions
    for i, c in enumerate(s):
        expected = chr((ord(c) - ord('a') + 4) % 26 + ord('a'))
        if output[i] != expected:
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
