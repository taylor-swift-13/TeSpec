
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    string = input[0]
    if not isinstance(string, str):
        return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, int):
        return False
    string = input[0]
    if output < 0:
        return False
    if len(string) == 0 and output != 0:
        return False
    if output > len(string):
        return False
    distinct = len(set(string.lower()))
    if output != distinct:
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
