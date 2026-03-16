
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    s = input[0]
    if not isinstance(output, int) or isinstance(output, bool):
        return False
    if output < 0:
        return False
    expected = 0
    for ch in s:
        # count only ASCII uppercase letters A-Z
        if 'A' <= ch <= 'Z':
            expected += ord(ch)
    return output == expected

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
