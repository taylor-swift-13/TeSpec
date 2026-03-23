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

def _orig_problem_119_pre(inputs):
    if len(inputs) != 2:
        return False
    for s in inputs:
        for c in s:
            if c != '(' and c != ')':
                return False
    return True

def _orig_problem_119_spec(inputs, output):
    return output == match_parens(inputs)

def problem_119_pre(lst):
    return bool(_orig_problem_119_pre(lst))

def problem_119_spec(lst, output):
    return bool(_orig_problem_119_spec(lst, output))
