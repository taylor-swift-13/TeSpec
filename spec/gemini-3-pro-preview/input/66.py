def is_upper(c):
    n = ord(c)
    return 65 <= n <= 90

def digitSum_calc(s):
    total = 0
    for c in s:
        if is_upper(c):
            total += ord(c)
    return total

def digitSum_spec(s, result):
    return result == digitSum_calc(s)
