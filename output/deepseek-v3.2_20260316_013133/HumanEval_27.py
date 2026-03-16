
def precondition(input):
    string, = input
    return isinstance(string, str)

def postcondition(input, output):
    string, = input
    if not isinstance(output, str):
        return False
    if len(string) != len(output):
        return False
    for c_in, c_out in zip(string, output):
        if c_in.islower():
            if not c_out.isupper():
                return False
            if c_in.upper() != c_out:
                return False
        elif c_in.isupper():
            if not c_out.islower():
                return False
            if c_in.lower() != c_out:
                return False
        else:
            if c_in != c_out:
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
