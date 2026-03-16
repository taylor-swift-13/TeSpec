
def precondition(input):
    text = input[0]
    return isinstance(text, str)

def postcondition(input, output):
    text = input[0]
    if not isinstance(output, bool):
        return False
    if not precondition(input):
        return False
    # Palindrome property: output should be True iff text equals its reverse
    expected = text == text[::-1]
    return output == expected

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
