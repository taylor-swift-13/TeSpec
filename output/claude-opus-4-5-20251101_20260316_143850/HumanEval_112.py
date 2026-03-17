
def precondition(args):
    if len(args) != 2:
        return False
    s, c = args
    if not isinstance(s, str) or not isinstance(c, str):
        return False
    return True

def postcondition(args, output):
    if not isinstance(output, tuple):
        return False
    if len(output) != 2:
        return False
    result_string, is_palindrome = output
    if not isinstance(result_string, str):
        return False
    if not isinstance(is_palindrome, bool):
        return False
    s, c = args
    # Check that result_string contains no characters from c
    for char in result_string:
        if char in c:
            return False
    # Check that result_string contains only characters from s (in order, with some removed)
    s_index = 0
    for char in result_string:
        while s_index < len(s) and s[s_index] != char:
            s_index += 1
        if s_index >= len(s):
            return False
        s_index += 1
    # Check that all characters from s not in c are in result_string
    filtered_s = ''.join(char for char in s if char not in c)
    if result_string != filtered_s:
        return False
    # Check that is_palindrome correctly indicates if result_string is a palindrome
    actual_is_palindrome = result_string == result_string[::-1]
    if is_palindrome != actual_is_palindrome:
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
