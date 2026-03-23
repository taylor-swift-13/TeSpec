def problem_72_pre(q, w):
    return True

def problem_72_spec(q, w, output):
    is_palindrome = (q == q[::-1])
    is_light = (sum(q) <= w)
    expected = is_palindrome and is_light
    return output == expected
