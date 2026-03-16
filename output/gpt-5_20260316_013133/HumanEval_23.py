
def precondition(input) -> bool:
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)

def postcondition(input, output) -> bool:
    if not precondition(input):
        return True
    s = input[0]
    return type(output) is int and output == len(s) and output >= 0

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
