import sys

# Increase recursion depth just in case of long strings
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

def problem_140_pre(s: str) -> bool:
    return True

def problem_140_spec(s: str, output: str) -> bool:
    return output == fix_spaces(s)

def _impl(text):
    ans = text
    for i in range(len(text), 2, -1):
        ans = ans.replace(" " * i, "-")
    return ans.replace(" ", "_")

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_140_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_140_spec(*input, output))

def fix_spaces(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
