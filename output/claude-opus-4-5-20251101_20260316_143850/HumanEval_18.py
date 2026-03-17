
def precondition(input):
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

def postcondition(input, output):
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    string, substring = input
    # Count cannot exceed possible starting positions
    if len(substring) > len(string):
        if output != 0:
            return False
    else:
        max_possible = len(string) - len(substring) + 1
        if output > max_possible:
            return False
    # Verify by counting overlapping occurrences
    count = 0
    start = 0
    while start <= len(string) - len(substring):
        pos = string.find(substring, start)
        if pos != -1:
            count += 1
            start = pos + 1
        else:
            break
    if output != count:
        return False
    return True

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
