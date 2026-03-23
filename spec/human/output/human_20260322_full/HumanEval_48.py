def problem_48_pre(input: str) -> bool:
    return True

def problem_48_spec(input: str, output: bool) -> bool:
    is_palindrome = (input == input[::-1])
    return output == is_palindrome

def _impl(text: str):
    return text == text[::-1]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_48_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_48_spec(*input, output))

def is_palindrome(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
