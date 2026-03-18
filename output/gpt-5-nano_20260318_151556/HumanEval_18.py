
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    s, sub = input
    return isinstance(s, str) and isinstance(sub, str)

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    s, sub = input
    if not isinstance(s, str) or not isinstance(sub, str):
        return False

    if sub == "":
        expected = len(s) + 1
    else:
        count = 0
        i = 0
        while True:
            idx = s.find(sub, i)
            if idx == -1:
                break
            count += 1
            i = idx + 1
        expected = count

    return isinstance(output, int) and output == expected

def _impl(string: str, substring: str) -> int:
    """
    Find how many times a given substring can be found in the original string. Count overlaping cases.
    0
    3
    3
    """
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
