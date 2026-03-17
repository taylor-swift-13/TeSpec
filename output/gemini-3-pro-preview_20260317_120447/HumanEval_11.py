from typing import List

def precondition(args):
    if not (isinstance(args, tuple) and len(args) == 2):
        return False
    a, b = args
    if not (isinstance(a, str) and isinstance(b, str)):
        return False
    if not (all(c in '01' for c in a) and all(c in '01' for c in b)):
        return False
    return True

def postcondition(args, output):
    if not isinstance(output, str):
        return False
    if not all(c in '01' for c in output):
        return False
    a, b = args
    try:
        # Check if the integer value of the XOR result matches
        # This handles cases regardless of leading zeros
        val_a = int(a, 2) if a else 0
        val_b = int(b, 2) if b else 0
        val_out = int(output, 2) if output else 0
        return (val_a ^ val_b) == val_out
    except ValueError:
        return False

def _impl(a: str, b: str) -> str:
    """Input are two strings a and b consisting only of 1s and 0s.
    Perform binary XOR on these inputs and return result also as a string.
    '100'"""
    return "".join(str(int(a[i]) ^ int(b[i])) for i in range(len(a)))

def string_xor(a: str, b: str) -> str:
    _input = (a, b)
    assert precondition(_input)
    _output = _impl(a, b)
    assert postcondition(_input, _output)
    return _output
