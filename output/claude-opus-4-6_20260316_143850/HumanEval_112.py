
def precondition(input):
    try:
        s, c = input
        # Both arguments must be strings
        if not isinstance(s, str):
            return False
        if not isinstance(c, str):
            return False
        return True
    except Exception:
        return False


def postcondition(input, output):
    try:
        s, c = input
        # Output must be a tuple of (string, bool)
        if not isinstance(output, tuple):
            return False
        if len(output) != 2:
            return False
        result_str, is_palindrome = output
        if not isinstance(result_str, str):
            return False
        if not isinstance(is_palindrome, bool):
            return False
        
        # The result string should be s with all characters in c removed
        expected_str = ''.join(ch for ch in s if ch not in c)
        if result_str != expected_str:
            return False
        
        # The boolean should indicate whether the result string is a palindrome
        expected_palindrome = (expected_str == expected_str[::-1])
        if is_palindrome != expected_palindrome:
            return False
        
        return True
    except Exception:
        return False

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
