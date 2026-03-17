
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    # input is tuple of positional args
    if not isinstance(input, tuple) or len(input) < 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    if not isinstance(output, str):
        return False
    # output must start with s
    if not output.startswith(s):
        return False
    # output must be a palindrome
    if output != output[::-1]:
        return False
    n = len(s)
    L_out = len(output)
    # If output length exceeds 2*n, it's not shortest (can always mirror s)
    if L_out > 2 * n:
        return False
    # Helper: determine if there exists a palindrome of length L that starts with s
    def possible_palindrome_with_prefix(s, L):
        # For every position i in prefix, its mirror position j = L-1-i must either be
        # beyond the prefix (free) or if within prefix must match s[j] == s[i].
        for i in range(len(s)):
            j = L - 1 - i
            if 0 <= j < len(s):
                if s[j] != s[i]:
                    return False
        return True
    # Find minimal possible length
    min_L = None
    for L in range(n, 2 * n + 1):
        if possible_palindrome_with_prefix(s, L):
            min_L = L
            break
    if min_L is None:
        return False
    # Output length must equal minimal length
    return L_out == min_L

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
