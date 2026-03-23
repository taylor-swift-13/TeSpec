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

# def is_rounded_to_2_decimals(rounded_val, original_val):
#     # Coq spec requires rounded_val to be exactly z/100 in Reals.
#     # We check if the exact rational value of the float is a multiple of 1/100.
#     f_rounded = Fraction(rounded_val)
#     is_exact = (100 % f_rounded.denominator == 0)
#     
#     # Coq spec: rounded_val - /200 <= original_val < rounded_val + /200
#     # We evaluate this using exact rationals to match Coq's Reals.
#     f_orig = Fraction(original_val)
#     lower_bound = f_rounded - Fraction(1, 200)
#     upper_bound = f_rounded + Fraction(1, 200)
#     
#     return is_exact and (lower_bound <= f_orig) and (f_orig < upper_bound)

def is_rounded_to_2_decimals(rounded_val, original_val):
    f_rounded = Fraction(str(rounded_val))
    if (f_rounded * 100).denominator != 1:
        return False
    z = int(f_rounded * 100)
    f_orig = Fraction(str(original_val))
    expected_z = round(f_orig * 100)
    return z == expected_z

def problem_71_pre(a, b, c):
    return True

def problem_71_spec(a, b, c, ret):
    # The spec is a disjunction (\/)
    cond1 = is_valid_triangle(a, b, c) and is_rounded_to_2_decimals(ret, heron_area(a, b, c))
    cond2 = (not is_valid_triangle(a, b, c)) and (ret == -1)
    return cond1 or cond2
