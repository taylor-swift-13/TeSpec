
import math

def _is_prime(n: int) -> bool:
    if not isinstance(n, int):
        return False
    if n < 2:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    r = math.isqrt(n)
    i = 3
    while i <= r:
        if n % i == 0:
            return False
        i += 2
    return True

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 3:
        return False
    n = input[0]
    # require n to be an integer (primality is defined for integers)
    if not isinstance(n, int):
        return False
    # x and y can be any values
    return True

def postcondition(input, output) -> bool:
    if not precondition(input):
        return False
    n, x, y = input
    if _is_prime(n):
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
