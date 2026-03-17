
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    string = input[0]
    return isinstance(string, str)


def postcondition(input, output) -> bool:
    string = input[0]
    if not isinstance(output, str):
        return False
    # Output must start with the input string
    if not output.startswith(string):
        return False
    # Output must be a palindrome
    if output != output[::-1]:
        return False
    # Output length must be at least as long as input
    if len(output) < len(string):
        return False
    # Output should not be longer than string + reverse of string
    max_len = len(string) * 2
    if len(output) > max_len:
        return False
    return True

def _impl(string: str) -> str:
    """Find the shortest palindrome that begins with a supplied string.
    Algorithm idea is simple:
    - Find the longest postfix of supplied string that is a palindrome.
    - Append to the end of the string reverse of a string prefix that comes before the palindromic suffix.
    ''
    'catac'
    'catac'"""
    if is_palindrome(string):
        return string
    for i in range(len(string)):
        if is_palindrome(string[i:]):
            return string + string[i-1::-1]

def make_palindrome(string: str) -> str:
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
