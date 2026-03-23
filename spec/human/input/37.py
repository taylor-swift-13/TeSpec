def _orig_problem_37_pre(input):
    return True

def _orig_problem_37_spec(input, output):
    if len(input) != len(output):
        return False
    if sorted(input) != sorted(output):
        return False
    for i in range(len(input)):
        if i % 2 != 0:
            if output[i] != input[i]:
                return False
    even_elements = [output[i] for i in range(len(output)) if i % 2 == 0]
    if even_elements != sorted(even_elements):
        return False
    return True

def problem_37_pre(l):
    return bool(_orig_problem_37_pre(l))

def problem_37_spec(l, output):
    return bool(_orig_problem_37_spec(l, output))
