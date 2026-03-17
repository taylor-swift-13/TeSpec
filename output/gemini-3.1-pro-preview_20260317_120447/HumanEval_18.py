
def precondition(inp):
    try:
        string, substring = inp
        return isinstance(string, str) and isinstance(substring, str)
    except Exception:
        return False

def postcondition(inp, out):
    try:
        string, substring = inp
        if not isinstance(out, int):
            return False
        if out < 0:
            return False
        if len(substring) > len(string) and out != 0:
            return False
        if len(substring) > 0 and out > len(string) - len(substring) + 1:
            return False
        if len(substring) == 0 and out > len(string) + 1:
            return False
        return True
    except Exception:
        return False

def _impl(string: str, substring: str) -> int:
    """Find how many times a given substring can be found in the original string. Count overlaping cases.
    0
    3
    3"""
    occurences = 0
    for i in range(len(string)):
        if string[i:].startswith(substring):
            occurences += 1
    return occurences

def how_many_times(string: str, substring: str) -> int:
    _input = (string, substring)
    assert precondition(_input)
    _output = _impl(string, substring)
    assert postcondition(_input, _output)
    return _output
