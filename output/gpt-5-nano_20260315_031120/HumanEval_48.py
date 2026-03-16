
def precondition(input):
    # input should be a tuple of exactly one argument, which must be a string
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    if not isinstance(input[0], str):
        return False
    return True

def postcondition(input, output):
    # input must be a valid single-string tuple; output must be bool and match palindrome check
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    text = input[0]
    if not isinstance(text, str):
        return False
    if not isinstance(output, bool):
        return False
    return output == (text == text[::-1])

def _impl(text: str):
    """Checks if given string is a palindrome
    True
    True
    True
    False"""
    return text == text[::-1]

def is_palindrome(text: str):
    _input = (text,)
    assert precondition(_input)
    _output = _impl(text)
    assert postcondition(_input, _output)
    return _output
