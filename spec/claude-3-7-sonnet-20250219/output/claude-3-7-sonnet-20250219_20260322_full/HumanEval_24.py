def largest_divisor_spec(n: int, d: int) -> bool:
    if n <= 1:
        return True
    if not (1 < d < n):
        return False
    if n % d != 0:
        return False
    for k in range(2, n):
        if n % k == 0:
            if d > k:
                return False
    return True

def _impl(n: int) -> int:
    for i in range(2, n):
        if n % i == 0: return n // i
    return 1

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(largest_divisor_spec(*input, output))

def largest_divisor(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
