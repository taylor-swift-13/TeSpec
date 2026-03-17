
def precondition(input_args):
    return isinstance(input_args[0], str)

def postcondition(input_args, output):
    text = input_args[0]
    return isinstance(output, bool) and output == (text == text[::-1])

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
