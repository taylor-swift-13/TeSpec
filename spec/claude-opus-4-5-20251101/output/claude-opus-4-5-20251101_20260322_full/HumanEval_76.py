def is_simple_power_spec(x: int, n: int, result: bool) -> bool:
    def is_simple_power(x_val: int, n_val: int) -> bool:
        if x_val == 1:
            return True
        if x_val == 0:
            return n_val == 0
        if n_val == 0:
            return False
        if n_val == 1:
            return False
        if n_val == -1:
            return x_val == -1
        
        val = 1
        while abs(val) < abs(x_val):
            val *= n_val
        return val == x_val

    return result == is_simple_power(x, n)

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
