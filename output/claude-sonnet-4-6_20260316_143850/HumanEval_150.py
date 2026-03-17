
def precondition(args) -> bool:
    if len(args) != 3:
        return False
    n, x, y = args
    if not isinstance(n, int):
        return False
    if not isinstance(x, (int, float)):
        return False
    if not isinstance(y, (int, float)):
        return False
    if n < 2:
        return False
    return True


def postcondition(args, output) -> bool:
    n, x, y = args

    def is_prime(num):
        if num < 2:
            return False
        for i in range(2, int(num ** 0.5) + 1):
            if num % i == 0:
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
