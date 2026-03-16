from typing import List

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, str) or not isinstance(b, str):
        return False
    if len(a) == 0 or len(b) == 0:
        return False
    for ch in a:
        if ch not in ("0", "1"):
            return False
    for ch in b:
        if ch not in ("0", "1"):
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    a, b = input
    if not isinstance(output, str):
        return False
    if len(output) == 0:
        return False
    for ch in output:
        if ch not in ("0", "1"):
            return False
    try:
        ai = int(a, 2)
        bi = int(b, 2)
        oi = int(output, 2)
    except Exception:
        return False
    return oi == (ai ^ bi)

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
