def is_prime(n: int) -> bool:
    if n < 2:
        return False
    d = 2
    while d * d <= n:
        if n % d == 0:
            return False
        d += 1
    return True

def intersection_spec(interval1_start: int, interval1_end: int, 
                      interval2_start: int, interval2_end: int, 
                      result: str) -> bool:
    l = max(interval1_start, interval2_start)
    r = min(interval1_end, interval2_end)
    length = r - l
    
    if l > r:
        expected = "NO"
    elif is_prime(length):
        expected = "YES"
    else:
        expected = "NO"
        
    return result == expected
