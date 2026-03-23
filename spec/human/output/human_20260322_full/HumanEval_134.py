space = chr(32)

def is_alpha(c):
    n = ord(c)
    return (65 <= n <= 90) or (97 <= n <= 122)

def ends_with_single_letter_pred(s):
    if not s:
        return False
    
    c = s[-1]
    pre = s[:-1]
    
    if not is_alpha(c):
        return False
        
    if not pre:
        return True
        
    return pre[-1] == space

def problem_134_pre(s):
    return True

def problem_134_spec(s, b):
    return b == ends_with_single_letter_pred(s)

def _impl(txt):
    if len(txt) == 0: return False
    if len(txt) == 1: return txt.isalpha()
    return txt[-1].isalpha() and txt[-2] == " "

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_134_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_134_spec(*input, output))

def check_if_last_char_is_a_letter(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
