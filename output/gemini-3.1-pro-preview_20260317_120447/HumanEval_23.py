
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    if not isinstance(input[0], str):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(output, int):
        return False
    if output != len(input[0]):
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
