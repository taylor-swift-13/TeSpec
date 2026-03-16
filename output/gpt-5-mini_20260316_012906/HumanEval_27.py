
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    if not precondition(input):
        return True
    s = input[0]
    if not isinstance(output, str):
        return False
    expected_parts = []
    for c in s:
        if c.islower():
            expected_parts.append(c.upper())
        elif c.isupper():
            expected_parts.append(c.lower())
        else:
            expected_parts.append(c)
    expected = ''.join(expected_parts)
    return output == expected

def _impl(string: str) -> str:
    """For a given string, flip lowercase characters to uppercase and uppercase to lowercase.
    'hELLO'"""
    return "".join(map(lambda x: x.swapcase(), string))

def flip_case(string: str) -> str:
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
