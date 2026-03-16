
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    s, sub = input
    if not isinstance(s, str) or not isinstance(sub, str):
        return False
    # require a non-empty substring to avoid ambiguous semantics for empty substring
    if len(sub) == 0:
        return False
    return True

def postcondition(input, output):
    # If precondition not met, do not enforce any particular postcondition
    if not precondition(input):
        return True
    s, sub = input
    if not isinstance(output, int) or output < 0:
        return False
    L = len(sub)
    expected = 0
    # count overlapping occurrences
    for i in range(0, len(s) - L + 1):
        if s[i:i+L] == sub:
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
