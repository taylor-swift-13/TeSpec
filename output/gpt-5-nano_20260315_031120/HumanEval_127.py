
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    i1, i2 = input

    def valid_interval(iv):
        if not isinstance(iv, (tuple, list)) or len(iv) != 2:
            return False
        a, b = iv
        if not isinstance(a, int) or not isinstance(b, int):
            return False
        if a > b:
            return False
        return True

    return valid_interval(i1) and valid_interval(i2)

def postcondition(input, output):
    if not precondition(input):
        return False

    i1, i2 = input
    a1, b1 = i1
    a2, b2 = i2

    start = max(a1, a2)
    end = min(b1, b2)
    inter_len = (end - start + 1) if end >= start else 0

    def is_prime(n):
        if n < 2:
            return False
        if n % 2 == 0:
            return n == 2
        p = 3
        while p * p <= n:
            if n % p == 0:
                return False
            p += 2
        return True

    expected = "YES" if is_prime(inter_len) else "NO"

    if not isinstance(output, str):
        return False
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
