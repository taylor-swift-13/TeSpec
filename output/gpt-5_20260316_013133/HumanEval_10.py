
def is_palindrome(string: str) -> bool:
    """ Test if given string is a palindrome """
    return string == string[::-1]

def precondition(input) -> bool:
    try:
        if not isinstance(input, tuple):
            return False
        if len(input) != 1:
            return False
        s = input[0]
        return isinstance(s, str)
    except Exception:
        return False

def postcondition(input, output) -> bool:
    if not precondition(input):
        return False
    s = input[0]
    if not isinstance(output, str):
        return False
    if not output.startswith(s):
        return False
    if output != output[::-1]:
        return False
    n = len(s)
    Lout = len(output)
    if Lout < n:
        return False

    def exists_palindrome_length(s, L):
        n = len(s)
        if L < n:
            return False
        for a in range(n):
            b = L - 1 - a
            if b < n and s[a] != s[b]:
                return False
        return True

    if not exists_palindrome_length(s, Lout):
        return False
    for L in range(n, Lout):
        if exists_palindrome_length(s, L):
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
