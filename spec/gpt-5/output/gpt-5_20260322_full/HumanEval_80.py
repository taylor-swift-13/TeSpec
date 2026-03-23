def nth_error_string(s, n):
    if n < 0 or n >= len(s):
        return None
    return s[n]

def distinct3(a, b, c):
    return a != b and a != c and b != c

def happy_prop(s):
    if len(s) < 3:
        return False
    
    # forall i, i + 2 < String.length s
    # In Python, range(len(s) - 2) iterates i from 0 to len(s) - 3 inclusive.
    # This corresponds exactly to indices i where i + 2 < len(s).
    for i in range(len(s) - 2):
        a = nth_error_string(s, i)
        b = nth_error_string(s, i + 1)
        c = nth_error_string(s, i + 2)
        
        if a is None or b is None or c is None:
            return False
            
        if not distinct3(a, b, c):
            return False
            
    return True

def is_happy_spec(s, r):
    return r == happy_prop(s)

def _impl(s):
    if len(s) < 3: return False
    for i in range(len(s) - 2):
        if s[i] == s[i + 1] or s[i] == s[i + 2] or s[i + 1] == s[i + 2]:
            return False
    return True

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_happy_spec(*input, output))

def is_happy(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
