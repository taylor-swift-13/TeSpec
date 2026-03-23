def char_in_string(c, s):
    return c in s

def _orig_same_chars_spec(s0, s1, output):
    return output == (set(s0) == set(s1))

def same_chars_spec(s0, s1, output):
    return bool(_orig_same_chars_spec(s0, s1, output))
