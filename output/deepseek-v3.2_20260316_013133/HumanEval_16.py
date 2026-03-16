
def precondition(input):
    string, = input
    return isinstance(string, str)

def postcondition(input, output):
    string, = input
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    if len(string) == 0:
        return output == 0
    # output should be at most the number of distinct characters in the lowercased string
    distinct_chars = len(set(string.lower()))
    return output <= distinct_chars

def _impl(string: str) -> int:
    """Given a string, find out how many distinct characters (regardless of case) does it consist of
    3
    4"""
    return len(set(string.lower()))

def count_distinct_characters(string: str) -> int:
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
