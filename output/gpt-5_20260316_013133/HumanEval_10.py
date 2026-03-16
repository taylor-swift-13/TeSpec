
def precondition(input) -> bool:
    try:
        if not isinstance(input, tuple):
            return False
        if len(input) != 1:
            return False
        return isinstance(input[0], str)
    except Exception:
        return False

def postcondition(input, output) -> bool:
    try:
        if not isinstance(input, tuple) or len(input) != 1 or not isinstance(input[0], str):
            return False
        if not isinstance(output, bool):
            return False
        s = input[0]
        expected = s == s[::-1]
        return output == expected
    except Exception:
        return False

def _impl(string: str) -> bool:
    """Test if given string is a palindrome"""
    if is_palindrome(string):
        return string
    for i in range(len(string)):
        if is_palindrome(string[i:]):
            return string + string[i-1::-1]

def is_palindrome(string: str) -> bool:
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
