
def precondition(input):
    # input must be a tuple with one string element
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    return isinstance(input[0], str)

def postcondition(input, output):
    # If precondition does not hold, do not enforce postcondition here
    if not precondition(input):
        return True
    s = input[0]
    # output must be a boolean and must indicate whether s equals its reverse
    return isinstance(output, bool) and output == (s == s[::-1])

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
