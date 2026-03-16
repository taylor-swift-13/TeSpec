from typing import List

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, str) or not isinstance(b, str):
        return False
    if len(a) == 0 or len(b) == 0:
        return False
    if any(ch not in '01' for ch in a) or any(ch not in '01' for ch in b):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, str) or not isinstance(b, str):
        return False
    if len(a) == 0 or len(b) == 0:
        return False
    if any(ch not in '01' for ch in a) or any(ch not in '01' for ch in b):
        return False
    if not isinstance(output, str):
        return False
    if len(output) == 0 or any(ch not in '01' for ch in output):
        return False
    try:
        expected = bin(int(a, 2) ^ int(b, 2))[2:]
    except ValueError:
        return False
    return output == expected

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
