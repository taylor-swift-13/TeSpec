
def precondition(args):
    s = args[0]
    return isinstance(s, str)

def postcondition(args, result):
    s = args[0]
    if not isinstance(s, str):
        return False
    expected = sum(ord(c) for c in s if c.isupper())
    return isinstance(result, int) and result == expected

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
