
def precondition(input):
    # input is a tuple of positional arguments
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return True

def postcondition(input, output):
    # input is a tuple of positional arguments
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return isinstance(output, int) and output == len(s)

def _impl(string: str) -> int:
    """
    Return length of given string
    0
    3
    """
    return len(string)

def strlen(string: str) -> int:
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
