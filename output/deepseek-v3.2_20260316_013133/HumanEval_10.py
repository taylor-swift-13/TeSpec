
def precondition(input):
    string, = input
    return isinstance(string, str)

def postcondition(input, output):
    string, = input
    if not isinstance(output, bool):
        return False
    if not isinstance(string, str):
        return False
    # output must be True iff string reads same forwards and backwards
    # ignoring case for consistency with typical palindrome definition
    normalized = ''.join(c.lower() for c in string if c.isalnum())
    is_pal = normalized == normalized[::-1]
    return output == is_pal

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
