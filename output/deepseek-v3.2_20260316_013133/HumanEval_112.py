
def precondition(input):
    s, c = input
    return isinstance(s, str) and isinstance(c, str)

def postcondition(input, output):
    s, c = input
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    result_str, is_pal = output
    if not isinstance(result_str, str) or not isinstance(is_pal, bool):
        return False
    
    # Check result_str construction
    expected_chars = [ch for ch in s if ch not in c]
    expected_str = ''.join(expected_chars)
    if result_str != expected_str:
        return False
    
    # Check palindrome property
    if is_pal != (result_str == result_str[::-1]):
        return False
    
    return True

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
