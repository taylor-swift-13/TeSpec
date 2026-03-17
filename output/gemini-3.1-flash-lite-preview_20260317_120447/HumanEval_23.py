
def precondition(input):
    return isinstance(input[0], str)

def postcondition(input, output):
    return output == len(input[0])

def _impl(string: str) -> int:
    """Return length of given string
    0
    3"""
    return len(string)

def strlen(string: str) -> int:
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
