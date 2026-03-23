def contains_substring(substring, s):
    return substring in s

def filtered(P, l, l_prime):
    # filtered is an inductive relation defining the behavior of a filter function.
    # It holds if l_prime is the list of elements in l for which P is true, preserving order.
    expected = [x for x in l if P(x)]
    return expected == l_prime

def filter_by_substring_spec(strings, substring, res):
    # Checks if 'res' is the result of filtering 'strings' to keep only those containing 'substring'.
    return filtered(lambda s: contains_substring(substring, s), strings, res)
