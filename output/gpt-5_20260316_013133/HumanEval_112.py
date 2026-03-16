
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    s, c = input
    return isinstance(s, str) and isinstance(c, str)

def postcondition(input, output):
    if not precondition(input):
        return True
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    res, is_pal = output
    if not isinstance(res, str) or not isinstance(is_pal, bool):
        return False
    s, c = input
    expected = "".join(ch for ch in s if ch not in set(c))
    if res != expected:
        return False
    return is_pal == (res == res[::-1])

def _impl(s,c):
    """Task
    We are given two strings s and c, you have to deleted all the characters in s that are equal to any character in c
    then check if the result string is palindrome.
    A string is called palindrome if it reads the same backward as forward.
    You should return a tuple containing the result string and True/False for the check.
    Example
    For s = "abcde", c = "ae", the result should be ('bcd',False)
    For s = "abcdef", c = "b"  the result should be ('acdef',False)
    For s = "abcdedcba", c = "ab", the result should be ('cdedc',True)"""
    ss = "".join(filter(lambda ch: ch not in c, s))
    return ss, ss == ss[::-1]

def reverse_delete(s,c):
    _input = (s, c)
    assert precondition(_input)
    _output = _impl(s, c)
    assert postcondition(_input, _output)
    return _output
