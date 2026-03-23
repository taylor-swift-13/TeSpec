def _orig_problem_26_pre(input):
    return True

def _orig_problem_26_spec(input, output):
    expected = [x for x in input if input.count(x) == 1]
    return output == expected

def problem_26_pre(numbers):
    return bool(_orig_problem_26_pre(numbers))

def problem_26_spec(numbers, output):
    return bool(_orig_problem_26_spec(numbers, output))
