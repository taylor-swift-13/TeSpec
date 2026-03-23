import math

def sum_squares_spec(lst, result):
    computed_sum = 0
    for x in lst:
        # In Coq's standard library, up(x) is the unique integer such that x < up(x) <= x + 1.
        # This is equivalent to floor(x) + 1 for all real numbers.
        c = math.floor(x) + 1
        computed_sum += c * c
    return result == computed_sum
