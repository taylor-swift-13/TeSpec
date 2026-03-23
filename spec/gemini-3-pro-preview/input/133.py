import math

def _orig_sum_squares_spec(lst, output):
    expected = 0
    for x in lst:
        ceil_x = math.floor(x) + 1
        expected += ceil_x * ceil_x
    return output == expected

def sum_squares_spec(lst, output):
    return bool(_orig_sum_squares_spec(lst, output))
