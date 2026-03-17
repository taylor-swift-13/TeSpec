
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 2:
        return False
    s, c = input_args
    return isinstance(s, str) and isinstance(c, str)

def postcondition(input_args, output):
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    s, c = input_args
    res, is_pal = output
    if not isinstance(res, str) or not (is_pal is True or is_pal is False):
        return False
    
    expected_res = "".join(char for char in s if char not in c)
    if res != expected_res:
        return False
        
    expected_is_pal = (res == res[::-1])
    return is_pal == expected_is_pal

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
