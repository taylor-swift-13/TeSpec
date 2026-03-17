
def precondition(args):
    x, n = args
    return isinstance(x, int) and isinstance(n, int) and n > 0

def postcondition(args, output):
    x, n = args
    if not isinstance(output, bool):
        return False
    if output:
        if x <= 0:
            return x == 1
        i = 0
        while n**i <= x:
            if n**i == x:
                return True
            i += 1
        return False
    else:
        i = 0
        while n**i <= x:
            if n**i == x:
                return False
            i += 1
        return True

def _impl(x, n):
    """Your task is to write a function that returns true if a number x is a simple
    power of n and false in other cases.
    x is a simple power of n if n**int=x
    For example:
    is_simple_power(1, 4) => true
    is_simple_power(2, 2) => true
    is_simple_power(8, 2) => true
    is_simple_power(3, 2) => false
    is_simple_power(3, 1) => false
    is_simple_power(5, 3) => false"""
    if x == 1: return True
    if n == 0: return x == 0
    if n == 1: return x == 1
    if n == -1: return abs(x) == 1
    p = n
    while abs(p) <= abs(x):
        if p == x: return True
        p = p * n
    return False

def is_simple_power(x, n):
    _input = (x, n)
    assert precondition(_input)
    _output = _impl(x, n)
    assert postcondition(_input, _output)
    return _output
