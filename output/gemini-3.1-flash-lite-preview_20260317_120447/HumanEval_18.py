
def precondition(input):
    string, substring = input
    return isinstance(string, str) and isinstance(substring, str) and len(substring) > 0

def postcondition(input, output):
    string, substring = input
    if not isinstance(output, int) or output < 0:
        return False
    
    count = 0
    start = 0
    while True:
        start = string.find(substring, start)
        if start == -1:
            break
        count += 1
        start += 1
    
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
