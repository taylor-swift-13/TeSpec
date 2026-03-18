
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str) or not isinstance(output, str):
        return False

    def shift_char(c):
        if 'a' <= c <= 'z':
            return chr((ord(c) - ord('a') + 4) % 26 + ord('a'))
        elif 'A' <= c <= 'Z':
            return chr((ord(c) - ord('A') + 4) % 26 + ord('A'))
        else:
            return c

    expected = ''.join(shift_char(ch) for ch in s)
    return output == expected

def _impl(s):
    """
    Create a function encrypt that takes a string as an argument and
    returns a string encrypted with the alphabet being rotated. 
    The alphabet should be rotated in a manner such that the letters 
    shift down by two multiplied to two places.
    For example:
    encrypt('hi') returns 'lm'
    encrypt('asdfghjkl') returns 'ewhjklnop'
    encrypt('gf') returns 'kj'
    encrypt('et') returns 'ix'
    """
    d = 'abcdefghijklmnopqrstuvwxyz'
    return "".join(map(lambda ch: chr((ord(ch) - ord("a") + 4) % 26 + ord("a")) if ch in d else ch, s))

def encrypt(s):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
