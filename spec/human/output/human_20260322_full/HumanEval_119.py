def check_parens_inner(l, counter):
    for char in l:
        if char == '(':
            counter += 1
        elif char == ')':
            if counter == 0:
                return False
            counter -= 1
    return counter == 0

def is_balanced(l):
    return check_parens_inner(l, 0)

def match_parens_impl(inputs):
    if len(inputs) == 2:
        s1 = inputs[0]
        s2 = inputs[1]
        if is_balanced(s1 + s2) or is_balanced(s2 + s1):
            return "Yes"
        else:
            return "No"
    return "No"

def match_parens(inputs):
    return match_parens_impl([list(s) for s in inputs])

def problem_119_pre(inputs):
    if len(inputs) != 2:
        return False
    for s in inputs:
        for c in s:
            if c != '(' and c != ')':
                return False
    return True

def problem_119_spec(inputs, output):
    return output == match_parens(inputs)

def _impl(lst):
    def valid_parens(s: str) -> bool:
        cnt = 0
        for ch in s:
            cnt = cnt + 1 if ch == "(" else cnt - 1
            if cnt < 0: return False
        return cnt == 0
    return "Yes" if valid_parens(lst[0] + lst[1]) or valid_parens(lst[1] + lst[0]) else "No"

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_119_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_119_spec(*input, output))

def match_parens(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
