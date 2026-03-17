
def precondition(args):
    n, x, y = args
    return isinstance(n, int)

def postcondition(args, output):
    n, x, y = args
    
    def is_prime(val):
        if val < 2:
            return False
        for i in range(2, int(val**0.5) + 1):
            if val % i == 0:
                return False
        return True

    if is_prime(n):
        return output == x
    else:
        return output == y

def _impl(n, x, y):
    """A simple program which should return the value of x if n is 
    a prime number and should return the value of y otherwise.

    Examples:
    for x_or_y(7, 34, 12) == 34
    for x_or_y(15, 8, 5) == 5"""
    def is_prime(a):
        return not (a < 2 or any(a % x == 0 for x in range(2, int(a ** 0.5) + 1)))
    return x if is_prime(n) else y

def x_or_y(n, x, y):
    _input = (n, x, y)
    assert precondition(_input)
    _output = _impl(n, x, y)
    assert postcondition(_input, _output)
    return _output
