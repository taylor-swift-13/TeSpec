
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, n = input
    return type(x) is int and type(n) is int

def postcondition(input, output):
    x, n = input
    if not isinstance(output, bool):
        return False

    def exists_simple_power(x, n):
        # Check if there exists an integer k >= 0 such that n**k == x
        if x == 1:
            return True  # k = 0 works for any n
        if n == 0:
            return x == 0  # k >= 1 yields 0
        if n == 1:
            return x == 1
        if n == -1:
            return x == 1 or x == -1
        if n > 0:
            if x <= 0:
                return False
            target = x
            base = n
            while target % base == 0:
                target //= base
            return target == 1
        else:
            # n < 0
            if x == 0:
                return False
            base = -n  # base > 0
            t = abs(x)
            count = 0
            while t % base == 0:
                t //= base
                count += 1
            if t != 1:
                return False
            # Sign must match parity of exponent
            if x < 0:
                return count % 2 == 1
            else:
                return count % 2 == 0

    expected = exists_simple_power(x, n)
    return (output and expected) or ((not output) and (not expected))

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
