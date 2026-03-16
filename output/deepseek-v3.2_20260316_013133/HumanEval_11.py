from typing import List

def precondition(input):
    a, b = input
    if not isinstance(a, str) or not isinstance(b, str):
        return False
    if len(a) == 0 or len(b) == 0:
        return False
    for char in a + b:
        if char not in '01':
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    if len(output) == 0:
        return False
    for char in output:
        if char not in '01':
            return False
    a, b = input
    if len(a) != len(b):
        return False
    if len(output) != len(a):
        return False
    for i in range(len(a)):
        if (a[i] == b[i] and output[i] != '0') or (a[i] != b[i] and output[i] != '1'):
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
