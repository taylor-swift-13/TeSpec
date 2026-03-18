
def precondition(input):
    try:
        if not isinstance(input, tuple) or len(input) != 3:
            return False
        n, x, y = input
        return isinstance(n, int) and isinstance(x, int) and isinstance(y, int)
    except Exception:
        return False

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 3:
        return False
    n, x, y = input
    if not (isinstance(n, int) and isinstance(x, int) and isinstance(y, int)):
        return False

    def is_prime(k):
        if k <= 1:
            return False
        if k <= 3:
            return True
        if k % 2 == 0:
            return False
        i = 3
        while i * i <= k:
            if k % i == 0:
                return False
            i += 2
        return True

    expected = x if is_prime(n) else y
    return output == expected

def _impl(n, x, y):
    """
    A simple program which should return the value of x if n is 
    a prime number and should return the value of y otherwise.

    Examples:
    for x_or_y(7, 34, 12) == 34
    for x_or_y(15, 8, 5) == 5
    """
    def is_prime(a):
        return not (a < 2 or any(a % x == 0 for x in range(2, int(a ** 0.5) + 1)))
    return x if is_prime(n) else y

def x_or_y(n, x, y):
    _input = (n, x, y)
    assert precondition(_input)
    _output = _impl(n, x, y)
    assert postcondition(_input, _output)
    return _output
