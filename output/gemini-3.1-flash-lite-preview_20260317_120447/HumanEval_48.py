
def precondition(input):
    text = input[0]
    return isinstance(text, str)

def postcondition(input, output):
    text = input[0]
    if output:
        return text == text[::-1]
    else:
        return text != text[::-1]

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
