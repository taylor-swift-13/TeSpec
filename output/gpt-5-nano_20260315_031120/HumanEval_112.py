
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    s, c = input
    if not isinstance(s, str) or not isinstance(c, str):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    s, c = input
    if not isinstance(s, str) or not isinstance(c, str):
        return False
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    res, ok = output
    if not isinstance(res, str) or not isinstance(ok, bool):
        return False
    expected = ''.join(ch for ch in s if ch not in c)
    palindrome = (expected == expected[::-1])
    return (res == expected) and (ok == palindrome)

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
