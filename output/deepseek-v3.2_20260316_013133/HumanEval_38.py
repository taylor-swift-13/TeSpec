
def precondition(input):
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    s = input[0]
    if not isinstance(output, str):
        return False
    if len(s) != len(output):
        return False
    if len(s) == 0:
        return output == ""
    for i in range(len(s)):
        if len(s) >= 3:
            group_idx = i // 3
            pos_in_group = i % 3
            shift = (pos_in_group + 1) % 3
            expected = s[group_idx * 3 + shift]
            if output[i] != expected:
                return False
        else:
            if output[i] != s[i]:
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
