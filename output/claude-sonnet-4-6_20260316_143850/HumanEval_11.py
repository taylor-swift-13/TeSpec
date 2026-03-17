from typing import List

def precondition(input) -> bool:
    if len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, str) or not isinstance(b, str):
        return False
    if len(a) == 0 or len(b) == 0:
        return False
    if not all(c in '01' for c in a):
        return False
    if not all(c in '01' for c in b):
        return False
    if len(a) != len(b):
        return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, str):
        return False
    a, b = input
    if len(output) != len(a):
        return False
    if not all(c in '01' for c in output):
        return False
    for i in range(len(a)):
        expected = '1' if a[i] != b[i] else '0'
        if output[i] != expected:
            return False
    return True

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
