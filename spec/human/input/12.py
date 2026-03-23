def _orig_problem_12_pre(input):
    return True

def _orig_problem_12_spec(input, output):
    if len(input) == 0:
        return output is None
    if output is None:
        return False
    for item in input:
        if item == output:
            return True
    return False

def problem_12_pre(strings):
    return bool(_orig_problem_12_pre(strings))

def problem_12_spec(strings, output):
    return bool(_orig_problem_12_spec(strings, output))
