
def precondition(args):
    return isinstance(args[0], str)

def postcondition(args, output):
    return isinstance(output, str) and len(args[0]) == len(output)

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
