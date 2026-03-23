def sum_squares_aux(lst, idx):
    total = 0
    for x in lst:
        if idx % 3 == 0:
            total += x * x
        elif idx % 4 == 0:
            total += x * x * x
        else:
            total += x
        idx += 1
    return total

def sum_squares_spec(lst, result):
    return result == sum_squares_aux(lst, 0)
