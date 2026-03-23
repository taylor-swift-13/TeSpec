def is_subsequence(l1, l2):
    it = iter(l2)
    for x in l1:
        found = False
        for y in it:
            if x == y:
                found = True
                break
        if not found:
            return False
    return True

def is_positive(r):
    return r > 0

def _orig_problem_30_pre(input):
    return True

def _orig_problem_30_spec(input, output):
    if not is_subsequence(output, input):
        return False
    for r in input + output:
        in_output = r in output
        in_input = r in input
        is_pos = is_positive(r)
        if in_output != (in_input and is_pos):
            return False
    return True

def problem_30_pre(l):
    return bool(_orig_problem_30_pre(l))

def problem_30_spec(l, output):
    return bool(_orig_problem_30_spec(l, output))
