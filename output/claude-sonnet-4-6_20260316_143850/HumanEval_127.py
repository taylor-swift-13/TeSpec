
def precondition(args):
    if len(args) != 2:
        return False
    interval1, interval2 = args
    if not (isinstance(interval1, (tuple, list)) and isinstance(interval2, (tuple, list))):
        return False
    if len(interval1) != 2 or len(interval2) != 2:
        return False
    s1, e1 = interval1
    s2, e2 = interval2
    if not all(isinstance(x, int) for x in [s1, e1, s2, e2]):
        return False
    if s1 > e1 or s2 > e2:
        return False
    return True


def postcondition(args, output):
    if output not in ("YES", "NO"):
        return False
    interval1, interval2 = args
    s1, e1 = interval1
    s2, e2 = interval2
    
    inter_start = max(s1, s2)
    inter_end = min(e1, e2)
    
    if inter_start > inter_end:
        return output == "NO"
    
    length = inter_end - inter_start
    
    def is_prime(n):
        if n < 2:
            return False
        if n == 2:
            return True
        if n % 2 == 0:
            return False
        for i in range(3, int(n**0.5) + 1, 2):
            if n % i == 0:
                return False
        return True
    
    if is_prime(length):
        return output == "YES"
    else:
        return output == "NO"

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
