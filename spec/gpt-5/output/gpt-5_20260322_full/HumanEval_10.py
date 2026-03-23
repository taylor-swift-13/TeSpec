def is_palindrome(string: str) -> bool:
    """ Test if given string is a palindrome """
    return string == string[::-1]

def strlen(s):
    return len(s)

def strrev(s):
    return s[::-1]

def palindrome(s):
    return s == strrev(s)

def begins_with(pref, s):
    return s.startswith(pref)

def is_palindrome_spec(s, b):
    return b == palindrome(s)

def make_palindrome_spec(s, t):
    # The spec requires t to be the shortest palindrome that starts with s.
    # This is constructed by taking s and appending the reverse of the prefix
    # of s that comes before the longest palindromic suffix of s.
    
    n = len(s)
    # Find the starting index of the longest palindromic suffix.
    # We iterate i from 0 upwards; the first i such that s[i:] is a palindrome
    # gives the longest such suffix (since length is n - i).
    split_idx = n
    for i in range(n + 1):
        if palindrome(s[i:]):
            split_idx = i
            break
            
    v = s[:split_idx]
    # The unique shortest palindrome t satisfying the conditions is s + strrev(v).
    expected_t = s + strrev(v)
    
    return t == expected_t

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
