
def precondition(input):
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)

def postcondition(input, output):
    if not precondition(input):
        return False
    if not isinstance(output, str):
        return False
    s = input[0]
    expected_chars = []
    for ch in s:
        if ch.islower():
            expected_chars.append(ch.upper())
        elif ch.isupper():
            expected_chars.append(ch.lower())
        else:
            expected_chars.append(ch)
    expected = ''.join(expected_chars)
    return output == expected

def _impl(string: str) -> str:
    """
    For a given string, flip lowercase characters to uppercase and uppercase to lowercase.
    'hELLO'
    """
    return "".join(map(lambda x: x.swapcase(), string))

def flip_case(string: str) -> str:
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
