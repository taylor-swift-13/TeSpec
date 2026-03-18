
def encode_shift(s: str):
    """
    returns encoded string by shifting every character by 5 in the alphabet.
    """
    return "".join([chr(((ord(ch) + 5 - ord("a")) % 26) + ord("a")) for ch in s])

def precondition(input):
    s = input[0]
    if not isinstance(s, str):
        return False
    # The string should only contain lowercase letters since encode_shift
    # produces lowercase letters (shifting lowercase letters wraps within a-z)
    for c in s:
        if not ('a' <= c <= 'z'):
            return False
    return True

def postcondition(input, output):
    s = input[0]
    if not isinstance(output, str):
        return False
    if len(output) != len(s):
        return False
    # All output characters should be lowercase letters
    for c in output:
        if not ('a' <= c <= 'z'):
            return False
    # Verify that encoding the output gives back the input
    # encode_shift shifts each character forward by 5 positions in the alphabet
    encoded = ""
    for ch in output:
        encoded += chr((ord(ch) - ord('a') + 5) % 26 + ord('a'))
    if encoded != s:
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
