def is_positive_odd_integer(n):
    return (n > 0) and (n % 2 == 1)

def sum_of_squares_of_positive_odd_integers(lst):
    total = 0
    for x in lst:
        if is_positive_odd_integer(x):
            total += x * x
    return total

def _orig_double_the_difference_spec(lst, output):
    return output == sum_of_squares_of_positive_odd_integers(lst)

def double_the_difference_spec(lst, output):
    return bool(_orig_double_the_difference_spec(lst, output))
