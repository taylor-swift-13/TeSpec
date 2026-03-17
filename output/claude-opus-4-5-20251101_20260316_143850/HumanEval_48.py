
def precondition(input):
    if len(input) != 1:
        return False
    text = input[0]
    if not isinstance(text, str):
        return False
    return True

def postcondition(input, output):
    text = input[0]
    if not isinstance(output, bool):
        return False
    # A string is a palindrome if it reads the same forwards and backwards
    expected = text == text[::-1]
    if output != expected:
        return False
    return True

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
