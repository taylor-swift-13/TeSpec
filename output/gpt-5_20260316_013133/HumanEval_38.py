
def precondition(input):
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)

def postcondition(input, output):
    if not precondition(input):
        return False
    s = input[0]
    if not isinstance(output, str):
        return False
    if len(output) != len(s):
        return False
    n_full = len(s) // 3
    # Check each full group of three is a rotation of the corresponding input group
    for i in range(n_full):
        a = s[i*3:(i+1)*3]
        b = output[i*3:(i+1)*3]
        if b not in {a, a[1:] + a[0], a[2] + a[:2]}:
            return False
    # Trailing characters (if any) remain unchanged
    if output[n_full*3:] != s[n_full*3:]:
        return False
    return True

def _impl(s: str):
    """returns encoded string by cycling groups of three characters."""
    groups = [s[(3 * i):min((3 * i + 3), len(s))] for i in range((len(s) + 2) // 3)]
    groups = [(group[2] + group[:2]) if len(group) == 3 else group for group in groups]
    return "".join(groups)

def encode_cyclic(s: str):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
