def sum_transformed(l, n):
    total = 0
    for h in l:
        if n % 3 == 0:
            transformed = h * h
        elif n % 4 == 0 and n % 3 != 0:
            transformed = h * h * h
        else:
            transformed = h
        total += transformed
        n += 1
    return total

def sum_squares_impl(lst):
    return sum_transformed(lst, 0)

def problem_142_pre(lst):
    return True

def problem_142_spec(lst, output):
    return output == sum_squares_impl(lst)
