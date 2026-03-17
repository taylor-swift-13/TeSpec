
def precondition(input):
    if len(input) != 1:
        return False
    string = input[0]
    if not isinstance(string, str):
        return False
    return True


def postcondition(input, output):
    string = input[0]
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    # The number of distinct characters (case-insensitive) cannot exceed the length of the string
    if output > len(string):
        return False
    # The number of distinct characters cannot exceed the number of unique lowercase characters
    expected = len(set(string.lower()))
    if output != expected:
        return False
    # If string is empty, result should be 0
    if len(string) == 0 and output != 0:
        return False
    # Result should be at least 1 if string is non-empty
    if len(string) > 0 and output < 1:
        return False
    return True

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
