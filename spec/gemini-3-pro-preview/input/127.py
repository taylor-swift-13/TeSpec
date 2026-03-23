def is_prime(n):
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def intersection_spec(interval1, interval2, result):
    s1, e1 = interval1
    s2, e2 = interval2
    inter_l = max(s1, s2)
    inter_r = min(e1, e2)
    length = inter_r - inter_l
    
    if is_prime(length):
        return result == "YES"
    else:
        return result == "NO"
