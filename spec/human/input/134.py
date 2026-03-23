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

def _orig_problem_134_pre(s):
    return True

def _orig_problem_134_spec(s, b):
    return b == ends_with_single_letter_pred(s)

def problem_134_pre(txt):
    return bool(_orig_problem_134_pre(txt))

def problem_134_spec(txt, output):
    return bool(_orig_problem_134_spec(txt, output))
