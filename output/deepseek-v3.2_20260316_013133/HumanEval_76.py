
def precondition(input):
    x, n = input
    if not isinstance(x, (int, float)):
        return False
    if not isinstance(n, (int, float)):
        return False
    if n <= 0:
        return False
    if x <= 0:
        return False
    return True

def postcondition(input, output):
    x, n = input
    if not isinstance(output, bool):
        return False
    if output:
        try:
            import math
            if x == 1:
                return True
            log_val = math.log(x, n)
            return abs(log_val - round(log_val)) < 1e-10
        except (ValueError, ZeroDivisionError):
            return False
    else:
        try:
            import math
            if x == 1:
                return False
            log_val = math.log(x, n)
            return abs(log_val - round(log_val)) >= 1e-10
        except (ValueError, ZeroDivisionError):
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
