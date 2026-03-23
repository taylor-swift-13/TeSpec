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
