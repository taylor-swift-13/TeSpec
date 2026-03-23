def digit_counts(n, e, o):
    """
    Implements the inductive relation digit_counts.
    It checks if 'e' and 'o' correctly represent the counts of even and odd digits
    in the decimal representation of 'n'.
    The relation is defined for n >= 0.
    """
    if n < 0:
        return False

    # Convert number to string to iterate over digits
    s = str(n)
    calc_e = 0
    calc_o = 0

    for char in s:
        digit = int(char)
        if digit % 2 == 0:
            calc_e += 1
        else:
            calc_o += 1

    return calc_e == e and calc_o == o

def _orig_even_odd_count_spec(num, output):
    """
    Specification function that checks if 'output' (a tuple of (even_count, odd_count))
    matches the digit counts of the absolute value of 'num'.
    """
    (even, odd) = output
    return digit_counts(abs(num), even, odd)

def even_odd_count_spec(num, output):
    return bool(_orig_even_odd_count_spec(num, output))
