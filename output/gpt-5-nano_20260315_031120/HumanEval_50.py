
def precondition(input):
    # input must be a tuple with a single string argument
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return True

def postcondition(input, output):
    # input should be a single string, output must be a string
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    if not isinstance(output, str):
        return False
    # Try to verify round-trip if encode_shift is available
    enc = globals().get('encode_shift')
    if callable(enc):
        try:
            return enc(output) == s
        except Exception:
            pass
    # Fallback: ensure length matches
    return len(output) == len(s)

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
