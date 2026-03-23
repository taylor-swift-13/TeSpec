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

def sum_squares_spec(lst, ans):
    return ans == sum_squares_aux(0, lst)
