
def precondition(input):
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    # String should only contain lowercase letters (as produced by encode_shift)
    for c in s:
        if not ('a' <= c <= 'z'):
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    s = input[0]
    # Output should have same length as input
    if len(output) != len(s):
        return False
    # Output should only contain lowercase letters
    for c in output:
        if not ('a' <= c <= 'z'):
            return False
    # Verify that encoding the output gives back the input
    # encode_shift shifts each character by 5 positions forward
    encoded = ""
    for c in output:
        encoded += chr((ord(c) - ord('a') + 5) % 26 + ord('a'))
    if encoded != s:
        return False
    return True

def _impl(s: str):
    """takes as input string encoded with encode_shift function. Returns decoded string.
    """
    return "".join([chr((ord(ch) - ord("a") - 5 + 26) % 26 + ord("a")) for ch in s])

def decode_shift(s: str):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
