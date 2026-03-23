def sum_even_at_odd_from(i, l):
    total = 0
    for idx, x in enumerate(l):
        if (i + idx) % 2 != 0 and x % 2 == 0:
            total += x
    return total

def sum_even_at_odd(l):
    return sum_even_at_odd_from(0, l)

def _orig_add_spec(lst, s):
    return s == sum_even_at_odd(lst)

def add_spec(lst, output):
    return bool(_orig_add_spec(lst, output))
