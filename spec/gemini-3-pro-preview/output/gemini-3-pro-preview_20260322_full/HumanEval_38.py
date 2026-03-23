def encode_cyclic(s: str):
    """
    returns encoded string by cycling groups of three characters.
    """
    # split string to groups. Each of length 3.
    groups = [s[(3 * i):min((3 * i + 3), len(s))] for i in range((len(s) + 2) // 3)]
    # cycle elements in each group. Unless group has fewer elements than 3.
    groups = [(group[1:] + group[0]) if len(group) == 3 else group for group in groups]
    return "".join(groups)

def string_to_list(s):
    return list(s)

def list_to_string(l):
    return "".join(l)

def encode_cyclic_list(l):
    res = []
    i = 0
    while i + 2 < len(l):
        res.append(l[i+1])
        res.append(l[i+2])
        res.append(l[i])
        i += 3
    while i < len(l):
        res.append(l[i])
        i += 1
    return res

def encode_cyclic_spec(s, res):
    return res == list_to_string(encode_cyclic_list(string_to_list(s)))

def decode_cyclic_list(l):
    res = []
    i = 0
    while i + 2 < len(l):
        res.append(l[i+2])
        res.append(l[i])
        res.append(l[i+1])
        i += 3
    while i < len(l):
        res.append(l[i])
        i += 1
    return res

def decode_cyclic_spec(s, res):
    return res == list_to_string(decode_cyclic_list(string_to_list(s)))

def _impl(s: str):
    groups = [s[(3 * i):min((3 * i + 3), len(s))] for i in range((len(s) + 2) // 3)]
    groups = [(group[2] + group[:2]) if len(group) == 3 else group for group in groups]
    return "".join(groups)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(decode_cyclic_spec(*input, output))

def decode_cyclic(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
