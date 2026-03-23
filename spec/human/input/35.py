def _orig_problem_35_pre(input):
    return len(input) > 0

def _orig_problem_35_spec(input, output):
    return output in input and all((x <= output for x in input))

def problem_35_pre(l):
    return bool(_orig_problem_35_pre(l))

def problem_35_spec(l, output):
    return bool(_orig_problem_35_spec(l, output))
