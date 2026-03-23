import math

def _orig_problem_99_pre(r):
    return True

# 旧版本按精确十进制有理数做“最近整数”比较。
# def _orig_problem_99_spec(r, output):
#     try:
#         r_frac = Fraction(r)
#     except Exception:
#         r_frac = Fraction(float(r))
#     res_int = int(output)
#     floor_r = math.floor(r_frac)
#     ceil_r = math.ceil(r_frac)
#     dist_floor = abs(r_frac - floor_r)
#     dist_ceil = abs(r_frac - ceil_r)
#     if dist_floor < dist_ceil:
#         expected = floor_r
#     elif dist_ceil < dist_floor:
#         expected = ceil_r
#     elif abs(floor_r) >= abs(ceil_r):
#         expected = floor_r
#     else:
#         expected = ceil_r
#     return res_int == expected

def _orig_problem_99_spec(r, output):
    try:
        expected = int(round(float(r)))
    except Exception:
        return False
    return int(output) == expected

def problem_99_pre(value):
    return bool(_orig_problem_99_pre(value))

def problem_99_spec(value, output):
    return bool(_orig_problem_99_spec(value, output))
