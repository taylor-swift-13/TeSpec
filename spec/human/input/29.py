def is_subsequence(l1, l2):
    i, j = 0, 0
    while i < len(l1) and j < len(l2):
        if l1[i] == l2[j]:
            i += 1
        j += 1
    return i == len(l1)

def _orig_problem_29_pre(input):
    return True

def _orig_problem_29_spec(input, substring, output):
    if not is_subsequence(output, input):
        return False
    for s in output:
        if s not in input:
            return False
        if not s.startswith(substring):
            return False
    for s in input:
        if s.startswith(substring):
            if s not in output:
                return False
    return True

def problem_29_pre(strings, prefix):
    return bool(_orig_problem_29_pre((strings, prefix)))

def problem_29_spec(strings, prefix, output):
    return bool(_orig_problem_29_spec(strings, prefix, output))
