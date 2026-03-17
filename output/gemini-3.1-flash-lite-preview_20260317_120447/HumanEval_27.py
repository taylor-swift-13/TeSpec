
def precondition(input):
    return isinstance(input[0], str)

def postcondition(input, output):
    s = input[0]
    return isinstance(output, str) and len(output) == len(s) and all(
        (c.isupper() and o == c.lower()) or 
        (c.islower() and o == c.upper()) or 
        (not c.isalpha() and o == c)
        for c, o in zip(s, output)
    )

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
