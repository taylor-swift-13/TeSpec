from fractions import Fraction

import math

def _orig_problem_99_pre(r):
    return True

def _orig_problem_99_spec(r, output):
    try:
        r_frac = Fraction(r)
    except Exception:
        r_frac = Fraction(float(r))
    res_int = int(output)
    floor_r = math.floor(r_frac)
    ceil_r = math.ceil(r_frac)
    dist_floor = abs(r_frac - floor_r)
    dist_ceil = abs(r_frac - ceil_r)
    if dist_floor < dist_ceil:
        expected = floor_r
    elif dist_ceil < dist_floor:
        expected = ceil_r
    elif abs(floor_r) >= abs(ceil_r):
        expected = floor_r
    else:
        expected = ceil_r
    return res_int == expected

def problem_99_pre(value):
    return bool(_orig_problem_99_pre(value))

def problem_99_spec(value, output):
    return bool(_orig_problem_99_spec(value, output))
