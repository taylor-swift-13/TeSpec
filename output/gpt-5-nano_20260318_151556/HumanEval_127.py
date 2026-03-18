
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    for interval in input:
        if not isinstance(interval, (tuple, list)) or len(interval) != 2:
            return False
        a, b = interval
        if not isinstance(a, int) or not isinstance(b, int):
            return False
        if a > b:
            return False
    return True

def postcondition(input, output):
    try:
        i1, i2 = input
        a1, b1 = i1
        a2, b2 = i2
        if not (isinstance(a1, int) and isinstance(b1, int) and isinstance(a2, int) and isinstance(b2, int)):
            return False
        L = max(a1, a2)
        R = min(b1, b2)
        if L > R:
            expected = "NO"
        else:
            length = R - L
            if length <= 1:
                expected = "NO"
            else:
                d = 2
                isprime = True
                while d * d <= length:
                    if length % d == 0:
                        isprime = False
                        break
                    d += 1
                expected = "YES" if isprime else "NO"
        return output == expected
    except Exception:
        return False

def _impl(interval1, interval2):
    """
    You are given two intervals,
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
