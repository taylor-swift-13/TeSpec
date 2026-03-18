
def is_palindrome(string: str) -> bool:
    """ Test if given string is a palindrome """
    return string == string[::-1]

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    if not precondition(input):
        return False
    s = input[0]
    if not isinstance(output, str):
        return False
    # output must start with the original string
    if not output.startswith(s):
        return False
    # output must be a palindrome
    if output != output[::-1]:
        return False
    Ls = len(s)
    Lout = len(output)
    if Lout < Ls:
        return False
    # output length should not exceed twice the input length (construction appends at most len(s) chars)
    if Lout > 2 * Ls and Ls != 0:
        return False
    # there must be no shorter palindrome that starts with s
    for L in range(Ls, Lout):
        # attempt to construct a palindrome of length L that starts with s
        t = [None] * L
        possible = True
        # assign the known prefix characters
        for i in range(Ls):
            if i >= L:
                possible = False
                break
            t[i] = s[i]
        if not possible:
            continue
        # propagate palindrome constraints
        for i in range(L):
            j = L - 1 - i
            if t[i] is not None and t[j] is not None:
                if t[i] != t[j]:
                    possible = False
                    break
            elif t[i] is not None and t[j] is None:
                t[j] = t[i]
            elif t[i] is None and t[j] is not None:
                t[i] = t[j]
        if not possible:
            continue
        # fill remaining positions with an arbitrary character
        for k in range(L):
            if t[k] is None:
                t[k] = 'a'
        candidate = ''.join(t)
        if candidate.startswith(s) and candidate == candidate[::-1]:
            # found a shorter valid palindrome
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
