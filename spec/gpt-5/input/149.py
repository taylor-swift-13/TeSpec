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

def sorted_list_sum_spec(lst, res):
    for s in set(lst + res):
        if even_length(s):
            if count(s, res) != count(s, lst):
                return False
        else:
            if count(s, res) != 0:
                return False
    for i in range(len(res) - 1):
        if not orderR(res[i], res[i+1]):
            return False
    return True
