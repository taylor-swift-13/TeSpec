def _orig_problem_43_pre(input):
    return True

def _orig_problem_43_spec(input, output):
    has_pair = False
    n = len(input)
    for i in range(n):
        for j in range(i + 1, n):
            if input[i] + input[j] == 0:
                has_pair = True
                break
        if has_pair:
            break
    return output == has_pair

def problem_43_pre(l):
    return bool(_orig_problem_43_pre(l))

def problem_43_spec(l, output):
    return bool(_orig_problem_43_spec(l, output))
