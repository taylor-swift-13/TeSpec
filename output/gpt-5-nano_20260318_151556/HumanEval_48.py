
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    text = input[0]
    return isinstance(text, str)

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    if not isinstance(output, bool):
        return False
    text = input[0]
    if not isinstance(text, str):
        return False
    expected = text == text[::-1]
    return output == expected

def _impl(text: str):
    """
    Checks if given string is a palindrome
    True
    True
    True
    False
    """
    return text == text[::-1]

def is_palindrome(text: str):
    _input = (text,)
    assert precondition(_input)
    _output = _impl(text)
    assert postcondition(_input, _output)
    return _output
