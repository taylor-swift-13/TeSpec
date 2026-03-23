def _orig_problem_72_pre(q, w):
    return True

def _orig_problem_72_spec(q, w, output):
    is_palindrome = q == q[::-1]
    is_light = sum(q) <= w
    expected = is_palindrome and is_light
    return output == expected

def problem_72_pre(q, w):
    return bool(_orig_problem_72_pre(q, w))

def problem_72_spec(q, w, output):
    return bool(_orig_problem_72_spec(q, w, output))
