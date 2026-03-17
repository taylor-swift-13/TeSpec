
def precondition(input_args: tuple) -> bool:
    s = input_args[0]
    return isinstance(s, str) and all('a' <= c <= 'z' for c in s)

def postcondition(input_args: tuple, output: str) -> bool:
    s = input_args[0]
    if not isinstance(output, str) or len(s) != len(output):
        return False
    for i in range(len(s)):
        expected_char = chr((ord(s[i]) - ord('a') + 4) % 26 + ord('a'))
        if output[i] != expected_char:
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
