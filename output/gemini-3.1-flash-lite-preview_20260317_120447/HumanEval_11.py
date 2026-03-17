from typing import List

def precondition(input):
    a, b = input
    return isinstance(a, str) and isinstance(b, str) and all(c in '01' for c in a) and all(c in '01' for c in b)

def postcondition(input, output):
    a, b = input
    if not isinstance(output, str) or not all(c in '01' for c in output):
        return False
    max_len = max(len(a), len(b))
    a_padded = a.zfill(max_len)
    b_padded = b.zfill(max_len)
    expected = "".join(str(int(x) ^ int(y)) for x, y in zip(a_padded, b_padded))
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
