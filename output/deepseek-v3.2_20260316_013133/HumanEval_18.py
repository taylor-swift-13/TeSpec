
def precondition(input):
    string, substring = input
    return isinstance(string, str) and isinstance(substring, str)

def postcondition(input, output):
    string, substring = input
    if not precondition(input):
        return False
    if not isinstance(output, int):
        return False
    # output must be non-negative integer
    if output < 0:
        return False
    # output must be at most len(string)
    if output > len(string):
        return False
    # if substring is empty, output should be len(string) + 1
    if len(substring) == 0:
        return output == len(string) + 1
    # basic sanity: if substring longer than string, output is 0
    if len(substring) > len(string):
        return output == 0
    # output should be at least 0 and at most possible maximum
    # maximum possible is len(string) - len(substring) + 1 for non-overlapping
    # but overlapping could be more, so we don't restrict upper bound further
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
