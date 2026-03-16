
def precondition(input) -> bool:
    # input should be a tuple of exactly two strings: (string, substring)
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    s, sub = input
    if not isinstance(s, str) or not isinstance(sub, str):
        return False
    if sub == "":
        return False
    return True

def postcondition(input, output) -> bool:
    # output should be the number of overlapping occurrences of substring in string
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    s, sub = input
    if not isinstance(s, str) or not isinstance(sub, str):
        return False
    if sub == "":
        return output == 0
    if not isinstance(output, int):
        return False
    expected = 0
    max_start = len(s) - len(sub)
    if max_start >= 0:
        for i in range(max_start + 1):
            if s[i:i+len(sub)] == sub:
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
