def is_prime(a):
    if a < 2:
        return False
    x = 2
    while x * x <= a:
        if a % x == 0:
            return False
        x += 1
    return True

def intersection_spec(interval1, interval2, result):
    l = max(interval1[0], interval2[0])
    r = min(interval1[1], interval2[1])
    diff = r - l
    prime = is_prime(diff)
    return (result == "YES" and prime) or (result == "NO" and not prime)
