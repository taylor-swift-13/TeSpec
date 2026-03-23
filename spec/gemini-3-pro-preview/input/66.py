def is_upper(c):
    n = ord(c)
    return 65 <= n <= 90

def digitSum_calc(s):
    total = 0
    for c in s:
        if is_upper(c):
            total += ord(c)
    return total

def _orig_digitSum_spec(s, output):
    return output == digitSum_calc(s)

def digitSum_spec(s, output):
    return bool(_orig_digitSum_spec(s, output))
