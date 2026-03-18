
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, n = input
    if not isinstance(x, int) or not isinstance(n, int):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    x, n = input

    def check(x, n):
        if x == 1:
            return True  # n**0 == 1 for any n
        if n == 0:
            return x == 0  # 0**k == 0 for k>=1
        if n == 1:
            return x == 1
        if n == -1:
            return x == 1 or x == -1
        val = 1
        while abs(val) <= abs(x):
            if val == x:
                return True
            val *= n
        return False

    expected = check(x, n)
    return bool(output) == expected

def _impl(x, n):
    """
    Your task is to write a function that returns true if a number x is a simple
    power of n and false in other cases.
    x is a simple power of n if n**int=x
    For example:
    is_simple_power(1, 4) => true
    is_simple_power(2, 2) => true
    is_simple_power(8, 2) => true
    is_simple_power(3, 2) => false
    is_simple_power(3, 1) => false
    is_simple_power(5, 3) => false
    """
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
