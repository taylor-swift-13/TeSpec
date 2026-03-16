
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 3:
        return False
    n, x, y = input
    if not isinstance(n, int) or not isinstance(x, int) or not isinstance(y, int):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 3:
        return False
    n, x, y = input
    if not isinstance(n, int) or not isinstance(x, int) or not isinstance(y, int):
        return False
    if not precondition(input):
        return True
    def is_prime(m: int) -> bool:
        if m < 2:
            return False
        if m == 2:
            return True
        if m % 2 == 0:
            return False
        limit = int(m ** 0.5)
        i = 3
        while i <= limit:
            if m % i == 0:
                return False
            i += 2
        return True
    expected = x if is_prime(n) else y
    return output == expected

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
