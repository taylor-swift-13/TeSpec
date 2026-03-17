
def precondition(args):
    return len(args) == 1 and isinstance(args[0], str)

def postcondition(args, output):
    if not isinstance(output, bool):
        return False
    if len(args[0]) <= 1:
        return output is True
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
