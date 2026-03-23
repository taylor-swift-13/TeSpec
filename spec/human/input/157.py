def _orig_problem_157_pre(a, b, c):
    return a > 0 and b > 0 and (c > 0)

def _orig_problem_157_spec(a, b, c, output):
    is_right = a * a + b * b == c * c or a * a + c * c == b * b or b * b + c * c == a * a
    return output == is_right

def problem_157_pre(a, b, c):
    return bool(_orig_problem_157_pre(a, b, c))

def problem_157_spec(a, b, c, output):
    return bool(_orig_problem_157_spec(a, b, c, output))
