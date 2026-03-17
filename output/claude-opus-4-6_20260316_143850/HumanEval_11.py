from typing import List

def precondition(input):
    a, b = input
    if not isinstance(a, str) or not isinstance(b, str):
        return False
    if len(a) == 0 or len(b) == 0:
        return False
    if not all(c in '01' for c in a):
        return False
    if not all(c in '01' for c in b):
        return False
    return True


def postcondition(input, output):
    a, b = input
    if not isinstance(output, str):
        return False
    if not all(c in '01' for c in output):
        return False
    # Verify the XOR result by converting to integers and back
    expected_int = int(a, 2) ^ int(b, 2)
    max_len = max(len(a), len(b))
    expected = bin(expected_int)[2:].zfill(max_len)
    # The output should represent the same integer value
    if int(output, 2) != expected_int:
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
