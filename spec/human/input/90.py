def _orig_problem_90_pre(l):
    return True

def _orig_problem_90_spec(l, output):
    if output is not None:
        z = output
        if not l:
            return False
        s1 = min(l)
        if z not in l:
            return False
        if s1 >= z:
            return False
        for y in l:
            if s1 < y and z > y:
                return False
        return True
    else:
        if not l:
            return True
        first = l[0]
        for x in l:
            if x != first:
                return False
        return True

def problem_90_pre(lst):
    return bool(_orig_problem_90_pre(lst))

def problem_90_spec(lst, output):
    return bool(_orig_problem_90_spec(lst, output))
