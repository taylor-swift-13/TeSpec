
def precondition(args: tuple) -> bool:
    return len(args) == 1 and isinstance(args[0], str)

def postcondition(args: tuple, output: any) -> bool:
    return isinstance(output, str) and len(output) == len(args[0])

def _impl(s: str):
    """takes as input string encoded with encode_shift function. Returns decoded string."""
    return "".join([chr((ord(ch) - ord("a") - 5 + 26) % 26 + ord("a")) for ch in s])

def decode_shift(s: str):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
