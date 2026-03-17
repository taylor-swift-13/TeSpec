
def precondition(args: tuple) -> bool:
    s, = args
    # Input must be a string
    if not isinstance(s, str):
        return False
    return True


def postcondition(args: tuple, output) -> bool:
    s, = args
    # Output must be an integer
    if not isinstance(output, int):
        return False
    # Output must be non-negative
    if output < 0:
        return False
    # Output should equal the sum of ASCII codes of uppercase characters
    expected = sum(ord(c) for c in s if c.isupper())
    if output != expected:
        return False
    return True

def _impl(s):
    """Task
    Write a function that takes a string as input and returns the sum of the upper characters only'
    ASCII codes.

    Examples:
        digitSum("") => 0
        digitSum("abAB") => 131
        digitSum("abcCd") => 67
        digitSum("helloE") => 69
        digitSum("woArBld") => 131
        digitSum("aAaaaXa") => 153"""
    return sum([ord(ch) for ch in s if ch.isupper()])

def digitSum(s):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
