
def is_palindrome(string: str) -> bool:
    """ Test if given string is a palindrome """
    return string == string[::-1]

def precondition(input):
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)

def postcondition(input, output):
    if not (isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)):
        return False
    if not isinstance(output, str):
        return False
    s = input[0]
    o = output
    if not o.startswith(s):
        return False
    if o != o[::-1]:
        return False
    for l in range(len(s), len(o)):
        k = l - len(s)
        cand = s + s[:k][::-1]
        if cand == cand[::-1]:
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
