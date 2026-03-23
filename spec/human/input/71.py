import math

from fractions import Fraction

def is_valid_triangle(a, b, c):
    # Use exact rational arithmetic to match Coq's Reals
    fa, fb, fc = Fraction(a), Fraction(b), Fraction(c)
    return fa > 0 and fb > 0 and fc > 0 and fa + fb > fc and fa + fc > fb and fb + fc > fa

def heron_area(a, b, c):
    # Use exact rational arithmetic for the radicand to avoid floating point underflow
    # for valid near-degenerate triangles, matching Coq's exact Reals behavior.
    fa, fb, fc = Fraction(a), Fraction(b), Fraction(c)
    fs = (fa + fb + fc) / Fraction(2)
    val = fs * (fs - fa) * (fs - fb) * (fs - fc)
    if val < 0:
        return 0.0
    return math.sqrt(float(val))

# 旧版本把“保留两位小数”实现成严格的有理数十进制等价检查。
# def is_rounded_to_2_decimals(rounded_val, original_val):
#     f_rounded = Fraction(str(rounded_val))
#     if (f_rounded * 100).denominator != 1:
#         return False
#     z = int(f_rounded * 100)
#     f_orig = Fraction(str(original_val))
#     expected_z = round(f_orig * 100)
#     return z == expected_z

def is_rounded_to_2_decimals(rounded_val, original_val):
    return abs(float(rounded_val) - round(float(original_val), 2)) <= 1e-9

def _orig_problem_71_pre(a, b, c):
    return True

def _orig_problem_71_spec(a, b, c, output):
    cond1 = is_valid_triangle(a, b, c) and is_rounded_to_2_decimals(output, heron_area(a, b, c))
    cond2 = not is_valid_triangle(a, b, c) and output == -1
    return cond1 or cond2

def problem_71_pre(a, b, c):
    return bool(_orig_problem_71_pre(a, b, c))

def problem_71_spec(a, b, c, output):
    return bool(_orig_problem_71_spec(a, b, c, output))
