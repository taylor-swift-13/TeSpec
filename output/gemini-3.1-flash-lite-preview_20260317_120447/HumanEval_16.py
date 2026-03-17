
def precondition(input):
    return isinstance(input[0], str)

def postcondition(input, output):
    return isinstance(output, int) and 0 <= output <= len(set(input[0].lower()))

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
