def char_in_string(c, s):
    return c in s

def same_chars_spec(s0, s1, result):
    return result == (set(s0) == set(s1))
