def _orig_problem_28_pre(input):
    return True

def _orig_problem_28_spec(input, output):
    return ''.join(input) == output

def problem_28_pre(strings):
    return bool(_orig_problem_28_pre(strings))

def problem_28_spec(strings, output):
    return bool(_orig_problem_28_spec(strings, output))
