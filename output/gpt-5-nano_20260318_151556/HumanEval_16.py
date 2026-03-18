
def precondition(input):
    # input should be a tuple of exactly one string argument
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return True

def postcondition(input, output):
    # input must be a single string argument; output should be int
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    if not isinstance(output, int):
        return False
    expected = len(set(ch.lower() for ch in s))
    return output == expected

def _impl(string: str) -> int:
    """
    Given a string, find out how many distinct characters (regardless of case) does it consist of
    3
    4
    """
    return len(set(string.lower()))

def count_distinct_characters(string: str) -> int:
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
