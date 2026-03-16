
def precondition(args):
    if not isinstance(args, tuple):
        return False
    if len(args) != 1:
        return False
    s = args[0]
    return isinstance(s, str)

def postcondition(args, output):
    if not isinstance(args, tuple) or len(args) != 1:
        return False
    s = args[0]
    if not isinstance(s, str):
        return False
    expected = sum(ord(c) for c in s if 'A' <= c <= 'Z')
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
