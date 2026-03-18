
def is_palindrome(string: str) -> bool:
    """ Test if given string is a palindrome """
    return string == string[::-1]

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
    # Output length must be >= input length
    if len(output) < len(string):
        return False
    # Output should not be longer than necessary:
    # at most len(string) - 1 extra characters appended
    if len(output) > 2 * len(string):
        return False
    return True

def _impl(string: str) -> str:
    """
    Find the shortest palindrome that begins with a supplied string.
    Algorithm idea is simple:
    - Find the longest postfix of supplied string that is a palindrome.
    - Append to the end of the string reverse of a string prefix that comes before the palindromic suffix.
    ''
    'catac'
    'catac'
    """
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
