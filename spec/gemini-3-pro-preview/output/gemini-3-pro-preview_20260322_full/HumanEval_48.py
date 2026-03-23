def string_rev(s):
    return s[::-1]

def is_palindrome_spec(text, result):
    return result == (text == string_rev(text))

def _impl(text: str):
    return text == text[::-1]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_palindrome_spec(*input, output))

def is_palindrome(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
