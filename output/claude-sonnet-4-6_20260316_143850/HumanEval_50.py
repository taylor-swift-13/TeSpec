
def precondition(input) -> bool:
    try:
        s = input[0]
        if not isinstance(s, str):
            return False
        return True
    except (IndexError, TypeError):
        return False


def postcondition(input, output) -> bool:
    try:
        s = input[0]
        if not isinstance(output, str):
            return False
        if len(output) != len(s):
            return False
        for c_in, c_out in zip(s, output):
            if c_in.isalpha() and not c_out.isalpha():
                return False
            if c_in.isupper() and not c_out.isupper():
                return False
            if c_in.islower() and not c_out.islower():
                return False
        return True
    except (IndexError, TypeError):
        return False

def _impl(s: str):
    """takes as input string encoded with encode_shift function. Returns decoded string."""
    return "".join([chr((ord(ch) - ord("a") - 5 + 26) % 26 + ord("a")) for ch in s])

def decode_shift(s: str):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
