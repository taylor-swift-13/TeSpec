
def precondition(input):
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    return True

def postcondition(input, output):
    s = input[0]
    if not isinstance(output, int):
        return False
    expected1 = sum(ord(c) for c in s if c.isupper())
    expected2 = sum(ord(c) for c in s if 'A' <= c <= 'Z')
    return output in (expected1, expected2)

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
