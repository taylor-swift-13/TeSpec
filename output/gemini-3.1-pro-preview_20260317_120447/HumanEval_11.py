from typing import List

def precondition(inputs: tuple) -> bool:
    if len(inputs) != 2:
        return False
    a, b = inputs
    if not isinstance(a, str) or not isinstance(b, str):
        return False
    if not a or not b:
        return False
    return set(a).issubset({'0', '1'}) and set(b).issubset({'0', '1'})

def postcondition(inputs: tuple, output: str) -> bool:
    if not isinstance(output, str):
        return False
    if not set(output).issubset({'0', '1'}):
        return False
    a, b = inputs
    try:
        expected = int(a, 2) ^ int(b, 2)
        if output == "":
            return expected == 0
        return int(output, 2) == expected
    except ValueError:
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
