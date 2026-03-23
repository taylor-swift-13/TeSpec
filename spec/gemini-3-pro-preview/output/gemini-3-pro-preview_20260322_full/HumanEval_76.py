def is_simple_power_spec(x: int, n: int, res: bool) -> bool:
    def is_simple_power(x: int, n: int) -> bool:
        if x == 1:
            return True
        if n == 0:
            return x == 0
        if n == 1:
            return x == 1
        if n == -1:
            return x == 1 or x == -1
        if x == 0:
            return False
        
        curr = x
        while curr % n == 0:
            curr //= n
        return curr == 1

    return is_simple_power(x, n) == res

def _impl(x, n):
    if x == 1: return True
    if n == 0: return x == 0
    if n == 1: return x == 1
    if n == -1: return abs(x) == 1
    p = n
    while abs(p) <= abs(x):
        if p == x: return True
        p = p * n
    return False

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_simple_power_spec(*input, output))

def is_simple_power(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
