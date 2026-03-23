def largest_divisor_spec(n, result):
    def coq_mod(a, b):
        if b == 0:
            return a
        return a % b

    cond1 = (result < n) and (coq_mod(n, result) == 0)
    if not cond1:
        return False

    for x in range(n):
        if coq_mod(n, x) == 0:
            if not (x <= result):
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
