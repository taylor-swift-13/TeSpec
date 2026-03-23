def drop(n, s):
    if n <= 0:
        return s
    return s[n:]

def is_prefixb(t, u):
    n = len(t)
    if n == 0:
        return True
    return u[:n] == t

def how_many_times_spec(s, substring, res):
    matches = [i for i in range(len(s)) if is_prefixb(substring, drop(i, s))]
    return res == len(matches)
