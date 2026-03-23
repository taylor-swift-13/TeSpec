def _orig_problem_42_pre(input):
    return True

def _orig_problem_42_spec(input, output):
    if len(input) != len(output):
        return False
    for i in range(len(output)):
        if output[i] != input[i] + 1:
            return False
    return True

def problem_42_pre(l):
    return bool(_orig_problem_42_pre(l))

def problem_42_spec(l, output):
    return bool(_orig_problem_42_spec(l, output))
