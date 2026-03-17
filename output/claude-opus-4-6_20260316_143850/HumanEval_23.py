
def precondition(input):
    args = input
    if len(args) != 1:
        return False
    string = args[0]
    if not isinstance(string, str):
        return False
    return True

def postcondition(input, output):
    args = input
    string = args[0]
    if not isinstance(output, int):
        return False
    if output != len(string):
        return False
    if output < 0:
        return False
    return True

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
