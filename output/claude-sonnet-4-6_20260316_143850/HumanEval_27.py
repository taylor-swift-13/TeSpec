
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    string = input[0]
    if not isinstance(string, str):
        return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, str):
        return False
    string = input[0]
    if len(output) != len(string):
        return False
    for i, c in enumerate(string):
        if c.islower():
            if output[i] != c.upper():
                return False
        elif c.isupper():
            if output[i] != c.lower():
                return False
        else:
            if output[i] != c:
                return False
    return True

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
