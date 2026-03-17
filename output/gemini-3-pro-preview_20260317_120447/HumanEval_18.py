
def precondition(args):
    if not isinstance(args, tuple) or len(args) != 2:
        return False
    s, sub = args
    return isinstance(s, str) and isinstance(sub, str)

def postcondition(args, output):
    if not isinstance(output, int) or output < 0:
        return False
    s, sub = args
    if not sub:
        return output == len(s) + 1
    
    expected = 0
    for i in range(len(s) - len(sub) + 1):
        if s[i : i + len(sub)] == sub:
            expected += 1
    return output == expected

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
