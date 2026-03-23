def count(x, l):
    return l.count(x)

def ascii_lt(a, b):
    return ord(a) < ord(b)

def string_lex_lt(s, t):
    return s < t

def string_lex_le(s, t):
    return s <= t

def even_length(s):
    return len(s) % 2 == 0

def orderR(s, t):
    if len(s) < len(t):
        return True
    if len(s) == len(t):
        return string_lex_le(s, t)
    return False

def _orig_sorted_list_sum_spec(lst, output):
    for s in set(lst + output):
        if even_length(s):
            if count(s, output) != count(s, lst):
                return False
        elif count(s, output) != 0:
            return False
    for i in range(len(output) - 1):
        if not orderR(output[i], output[i + 1]):
            return False
    return True

def sorted_list_sum_spec(lst, output):
    return bool(_orig_sorted_list_sum_spec(lst, output))
