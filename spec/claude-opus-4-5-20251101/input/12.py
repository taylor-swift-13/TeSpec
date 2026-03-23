def string_length(s):
    return len(s)

def max_length(strings):
    if not strings:
        return 0
    return max(string_length(s) for s in strings)

def find_first_with_length(strings, length):
    for s in strings:
        if string_length(s) == length:
            return s
    return None

def _orig_longest_spec(strings, output):
    if not strings:
        return output is None
    maxlen = max_length(strings)
    if output is None:
        return False
    s = output
    if s not in strings:
        return False
    if string_length(s) != maxlen:
        return False
    idx1_list = [i for (i, x) in enumerate(strings) if x == s]
    idx2_list = [i for (i, x) in enumerate(strings) if string_length(x) == maxlen]
    for idx1 in idx1_list:
        for idx2 in idx2_list:
            if not idx1 <= idx2:
                return False
    return True

def longest_spec(strings, output):
    return bool(_orig_longest_spec(strings, output))
