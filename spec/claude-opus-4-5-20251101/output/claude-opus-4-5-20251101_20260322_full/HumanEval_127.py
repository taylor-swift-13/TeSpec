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

def _impl(interval1, interval2):
    def is_prime(a):
        return not (a < 2 or any(a % x == 0 for x in range(2, int(a ** 0.5) + 1)))
    if interval1[0] > interval2[0]: interval1, interval2 = interval2, interval1
    l, r = interval2[0], min(interval1[1], interval2[1])
    return "YES" if is_prime(r - l) else "NO"

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(intersection_spec(*input, output))

def intersection(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
