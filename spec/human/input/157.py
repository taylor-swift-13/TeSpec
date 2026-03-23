def problem_157_pre(a, b, c):
    return a > 0 and b > 0 and c > 0

def problem_157_spec(a, b, c, res):
    is_right = (a * a + b * b == c * c) or \
               (a * a + c * c == b * b) or \
               (b * b + c * c == a * a)
    return res == is_right
