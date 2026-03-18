
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 2:
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
    out_s, out_b = output
    if not isinstance(out_s, str) or not isinstance(out_b, bool):
        return False

    to_delete = set(c)
    res_expected = ''.join(ch for ch in s if ch not in to_delete)
    is_pal_expected = (res_expected == res_expected[::-1])

    return (out_s == res_expected) and (out_b == is_pal_expected)

def _impl(s,c):
    """
    Task
    We are given two strings s and c, you have to deleted all the characters in s that are equal to any character in c
    then check if the result string is palindrome.
    A string is called palindrome if it reads the same backward as forward.
    You should return a tuple containing the result string and True/False for the check.
    Example
    For s = "abcde", c = "ae", the result should be ('bcd',False)
    For s = "abcdef", c = "b"  the result should be ('acdef',False)
    For s = "abcdedcba", c = "ab", the result should be ('cdedc',True)
    """
    ss = "".join(filter(lambda ch: ch not in c, s))
    return ss, ss == ss[::-1]

def reverse_delete(s,c):
    _input = (s, c)
    assert precondition(_input)
    _output = _impl(s, c)
    assert postcondition(_input, _output)
    return _output
