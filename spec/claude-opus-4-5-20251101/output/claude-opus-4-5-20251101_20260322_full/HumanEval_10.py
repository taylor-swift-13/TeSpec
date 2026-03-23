def is_palindrome(string: str) -> bool:
    """ Test if given string is a palindrome """
    return string == string[::-1]

def rev_list(l):
    return l[::-1]

def string_to_list(s):
    return list(s)

def list_to_string(l):
    return "".join(l)

def is_palindrome_list(l):
    return l == rev_list(l)

def is_palindrome(s):
    return is_palindrome_list(string_to_list(s))

def is_palindrome_spec(s):
    return is_palindrome(s)

def suffix(l, i):
    return l[i:]

def prefix(l, i):
    return l[:i]

def make_palindrome_spec(s, result):
    l = string_to_list(s)
    r = string_to_list(result)
    
    expected_r = None
    for i in range(len(l) + 1):
        suff = suffix(l, i)
        if suff == rev_list(suff):
            expected_r = l + rev_list(prefix(l, i))
            break
            
    return r == expected_r

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
