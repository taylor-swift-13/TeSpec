def is_prime(a):
    if a < 2:
        return False
    x = 2
    while x * x <= a:
        if a % x == 0:
            return False
        x += 1
    return True

def _orig_intersection_spec(interval1, interval2, output):
    l = max(interval1[0], interval2[0])
    r = min(interval1[1], interval2[1])
    diff = r - l
    prime = is_prime(diff)
    return output == 'YES' and prime or (output == 'NO' and (not prime))

def intersection_spec(interval1, interval2, output):
    return bool(_orig_intersection_spec(interval1, interval2, output))
