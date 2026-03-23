import math

def _orig_sum_squares_spec(lst, output):
    computed_sum = 0
    for x in lst:
        c = math.floor(x) + 1
        computed_sum += c * c
    return output == computed_sum

def sum_squares_spec(lst, output):
    return bool(_orig_sum_squares_spec(lst, output))
