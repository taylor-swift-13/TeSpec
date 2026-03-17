
def precondition(input) -> bool:
    if len(input) != 2:
        return False
    string, substring = input
    if not isinstance(string, str):
        return False
    if not isinstance(substring, str):
        return False
    if len(substring) == 0:
        return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    string, substring = input
    if len(substring) > len(string):
        if output != 0:
            return False
    count = 0
    start = 0
    while True:
        pos = string.find(substring, start)
        if pos == -1:
            break
        count += 1
        start = pos + 1
    return output == count

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
