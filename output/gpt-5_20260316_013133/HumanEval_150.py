
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 3:
        return False
    n, x, y = input
    return isinstance(n, int)


def postcondition(input, output):
    if not precondition(input):
        return True
    n, x, y = input

    def is_prime(k):
        if k < 2:
            return False
        if k % 2 == 0:
            return k == 2
        i = 3
        while i * i <= k:
            if k % i == 0:
                return False
            i += 2
        return True

    expected = x if is_prime(n) else y

    def same_value(a, b):
        if a is b:
            return True
        try:
            if a == b:
                return True
        except Exception:
            pass
        try:
            return isinstance(a, float) and isinstance(b, float) and (a != a) and (b != b)
        except Exception:
            return False

    return same_value(output, expected)

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
