import sys

sys.setrecursionlimit(10000)

space = " "

underscore = "_"

dash = "-"

def skip_spaces(l):
    if not l:
        return []
    for i, c in enumerate(l):
        if c != space:
            return l[i:]
    return []

def fix_spaces_func(fuel, l):
    if fuel == 0:
        return []
    if not l:
        return []
    
    c = l[0]
    tl = l[1:]
    
    if c == space:
        if not tl:
            return [underscore]
        
        c2 = tl[0]
        tl2 = tl[1:]
        
        if c2 == space:
            return [dash] + fix_spaces_func(fuel - 1, skip_spaces(tl2))
        else:
            return [underscore] + fix_spaces_func(fuel - 1, tl)
    else:
        return [c] + fix_spaces_func(fuel - 1, tl)

def fix_spaces(s: str) -> str:
    l = list(s)
    res = fix_spaces_func(len(l) + 1, l)
    return "".join(res)

def _orig_problem_140_pre(s: str) -> bool:
    return True

def _orig_problem_140_spec(s: str, output: str) -> bool:
    return output == fix_spaces(s)

def problem_140_pre(text):
    return bool(_orig_problem_140_pre(text))

def problem_140_spec(text, output):
    return bool(_orig_problem_140_spec(text, output))
