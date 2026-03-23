import math

def is_ceil(x, z):
    return (z - 1 < x) and (x <= z)

def problem_133_pre(lst):
    return True

def problem_133_spec(lst, s):
    expected_s = sum(math.ceil(x) ** 2 for x in lst)
    return expected_s == s
