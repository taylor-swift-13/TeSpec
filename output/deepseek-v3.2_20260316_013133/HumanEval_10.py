
def is_palindrome(string: str) -> bool:
    """ Test if given string is a palindrome """
    return string == string[::-1]

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    string = input[0]
    if not isinstance(string, str):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    if not isinstance(output, str):
        return False
    string = input[0]
    if not string.startswith(output):
        return False
    if output != output[::-1]:
        return False
    for i in range(len(string), len(output) + 1):
        candidate = string + string[:i - len(string)][::-1]
        if candidate == candidate[::-1]:
            return len(output) <= len(candidate)
    return False

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
