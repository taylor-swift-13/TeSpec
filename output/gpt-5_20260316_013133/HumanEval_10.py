
def precondition(input):
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)

def postcondition(input, output):
    if not precondition(input):
        return True
    s = input[0]
    if not isinstance(output, str):
        return False
    n = len(s)
    i = n
    for j in range(n + 1):
        suf = s[j:]
        if suf == suf[::-1]:
            i = j
            break
    expected = s + s[:i][::-1]
    if output != expected:
        return False
    if not output.startswith(s):
        return False
    if output != output[::-1]:
        return False
    return True

def _impl(string: str) -> str:
    """Find the shortest palindrome that begins with a supplied string.
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
