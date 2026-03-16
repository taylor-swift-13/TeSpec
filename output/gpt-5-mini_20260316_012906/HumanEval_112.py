
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    s, c = input
    return isinstance(s, str) and isinstance(c, str)

def postcondition(input, output):
    if not precondition(input):
        return True
    if not isinstance(output, tuple):
        return False
    if len(output) != 2:
        return False
    res, flag = output
    if not isinstance(res, str):
        return False
    if not isinstance(flag, bool):
        return False
    s, c = input
    remove = set(c)
    expected = ''.join(ch for ch in s if ch not in remove)
    expected_flag = (expected == expected[::-1])
    return res == expected and flag == expected_flag

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
