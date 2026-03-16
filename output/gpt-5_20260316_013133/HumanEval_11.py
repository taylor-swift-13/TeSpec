from typing import List

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, str) or not isinstance(b, str):
        return False
    valid_chars = {'0', '1'}
    return all(c in valid_chars for c in a) and all(c in valid_chars for c in b)


def postcondition(input, output):
    if not isinstance(output, str):
        return False
    a, b = input
    # Output must be binary if non-empty
    if output != "" and any(c not in ("0", "1") for c in output):
        return False

    # Compute right-aligned, zero-padded XOR
    max_len = max(len(a), len(b))
    ap = a.rjust(max_len, "0")
    bp = b.rjust(max_len, "0")
    padded_xor = "".join("1" if x != y else "0" for x, y in zip(ap, bp))

    # Accepted outputs:
    # - exact padded XOR (preserves length/max_len)
    # - padded XOR with leading zeros stripped (canonical numeric form), using "0" for all-zero
    acceptable = {padded_xor}
    trimmed = padded_xor.lstrip("0")
    acceptable.add(trimmed if trimmed != "" else "0")
    # If both inputs are empty, allow empty output as well
    if len(a) == 0 and len(b) == 0:
        acceptable.add("")

    return output in acceptable

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
