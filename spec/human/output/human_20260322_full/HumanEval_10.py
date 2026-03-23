def is_palindrome(string: str) -> bool:
    """ Test if given string is a palindrome """
    return string == string[::-1]

def palindrome(s: str) -> bool:
    return s == s[::-1]

def problem_10_pre() -> bool:
    return True

def problem_10_spec(input: str, output: str) -> bool:
    if not input:
        shortest = ""
    else:
        shortest = input + input[::-1]
        for i in range(len(input)):
            postfix = input[i:]
            if postfix == postfix[::-1]:
                shortest = input + input[:i][::-1]
                break
    return output == shortest

def _impl(string: str) -> str:
    if is_palindrome(string):
        return string
    for i in range(len(string)):
        if is_palindrome(string[i:]):
            return string + string[i-1::-1]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_10_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_10_spec(*input, output))

def make_palindrome(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
