def is_prime(n):
    if n <= 1:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    for i in range(3, int(n**0.5) + 1, 2):
        if n % i == 0:
            return False
    return True

def problem_127_pre(i1, i2):
    s1, e1 = i1
    s2, e2 = i2
    return s1 <= e1 and s2 <= e2

def problem_127_spec(i1, i2, output):
    s1, e1 = i1
    s2, e2 = i2
    
    s_inter = max(s1, s2)
    e_inter = min(e1, e2)
    
    if s_inter <= e_inter:
        length = e_inter - s_inter
        if is_prime(length):
            return output == "YES"
        else:
            return output == "NO"
    else:
        return output == "NO"

def _impl(interval1, interval2):
    def is_prime(a):
        return not (a < 2 or any(a % x == 0 for x in range(2, int(a ** 0.5) + 1)))
    if interval1[0] > interval2[0]: interval1, interval2 = interval2, interval1
    l, r = interval2[0], min(interval1[1], interval2[1])
    return "YES" if is_prime(r - l) else "NO"

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_127_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_127_spec(*input, output))

def intersection(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
