def drop(n, s):
    if n <= 0:
        return s
    return s[n:]

def is_prefixb(t, u):
    n = len(t)
    if n == 0:
        return True
    return u[:n] == t

def _orig_how_many_times_spec(s, substring, output):
    matches = [i for i in range(len(s)) if is_prefixb(substring, drop(i, s))]
    return output == len(matches)

def how_many_times_spec(string, substring, output):
    return bool(_orig_how_many_times_spec(string, substring, output))
