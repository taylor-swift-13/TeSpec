def sum_squares_aux(i, lst):
    total = 0
    for x in lst:
        if i % 3 == 0:
            term = x * x
        elif i % 4 == 0:
            term = x * x * x
        else:
            term = x
        total += term
        i += 1
    return total

def _orig_sum_squares_spec(lst, output):
    return output == sum_squares_aux(0, lst)

def sum_squares_spec(lst, output):
    return bool(_orig_sum_squares_spec(lst, output))
