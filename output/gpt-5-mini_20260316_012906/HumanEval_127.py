
import math

def precondition(input):
    try:
        iv1, iv2 = input
    except Exception:
        return False
    for iv in (iv1, iv2):
        if not (isinstance(iv, (list, tuple)) and len(iv) == 2):
            return False
        s, e = iv
        if not isinstance(s, int) or not isinstance(e, int):
            return False
        if s > e:
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    if not isinstance(output, str):
        return False
    if output not in ("YES", "NO"):
        return False
    iv1, iv2 = input
    s1, e1 = iv1
    s2, e2 = iv2
    inter_len = min(e1, e2) - max(s1, s2)
    def is_prime(n):
        if n <= 1:
            return False
        if n <= 3:
            return True
        if n % 2 == 0:
            return False
        r = math.isqrt(n)
        i = 3
        while i <= r:
            if n % i == 0:
                return False
            i += 2
        return True
    expected = "YES" if inter_len > 1 and is_prime(inter_len) else "NO"
    return output == expected

def _impl(interval1, interval2):
    """You are given two intervals,
    where each interval is a pair of integers. For example, interval = (start, end) = (1, 2).
    The given intervals are closed which means that the interval (start, end)
    includes both start and end.
    For each given interval, it is assumed that its start is less or equal its end.
    Your task is to determine whether the length of intersection of these two 
    intervals is a prime number.
    Example, the intersection of the intervals (1, 3), (2, 4) is (2, 3)
    which its length is 1, which not a prime number.
    If the length of the intersection is a prime number, return "YES",
    otherwise, return "NO".
    If the two intervals don't intersect, return "NO".


    [input/output] samples:
    intersection((1, 2), (2, 3)) ==> "NO"
    intersection((-1, 1), (0, 4)) ==> "NO"
    intersection((-3, -1), (-5, 5)) ==> "YES"
    """
    def is_prime(a):
        return not (a < 2 or any(a % x == 0 for x in range(2, int(a ** 0.5) + 1)))
    if interval1[0] > interval2[0]: interval1, interval2 = interval2, interval1
    l, r = interval2[0], min(interval1[1], interval2[1])
    return "YES" if is_prime(r - l) else "NO"

def intersection(interval1, interval2):
    _input = (interval1, interval2)
    assert precondition(_input)
    _output = _impl(interval1, interval2)
    assert postcondition(_input, _output)
    return _output
