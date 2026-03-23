def is_palindrome(string: str) -> bool:
    """ Test if given string is a palindrome """
    return string == string[::-1]

def is_palindrome(l):
    return l == l[::-1]

def make_palindrome_spec(s, res):
    for i in range(len(s) + 1):
        p = s[:i]
        q = s[i:]
        if is_palindrome(q):
            expected_res = s + p[::-1]
            return res == expected_res
    return False

def _impl(string: str) -> str:
    if is_palindrome(string):
        return string
    for i in range(len(string)):
        if is_palindrome(string[i:]):
            return string + string[i-1::-1]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(make_palindrome_spec(*input, output))

def make_palindrome(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
