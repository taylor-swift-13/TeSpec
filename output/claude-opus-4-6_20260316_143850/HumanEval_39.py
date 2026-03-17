
def precondition(input):
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 1:
        return False
    return True


def is_prime(num):
    if num < 2:
        return False
    if num == 2:
        return True
    if num % 2 == 0:
        return False
    for i in range(3, int(num**0.5) + 1, 2):
        if num % i == 0:
            return False
    return True


def is_fibonacci(num):
    if num < 0:
        return False
    a, b = 0, 1
    while a < num:
        a, b = b, a + b
    return a == num


def postcondition(input, output):
    n = input[0]
    if not isinstance(output, int):
        return False
    if output < 2:
        return False
    if not is_prime(output):
        return False
    if not is_fibonacci(output):
        return False
    # Check that there are exactly n-1 prime Fibonacci numbers less than output
    count = 0
    a, b = 0, 1
    while a < output:
        if is_prime(a):
            count += 1
        a, b = b, a + b
    if count != n - 1:
        return False
    return True

def _impl(n: int):
    """prime_fib returns n-th number that is a Fibonacci number and it's also prime.
    2
    3
    5
    13
    89"""
    import random
    def miller_rabin(n, k=10):
        """Test if n is prime using the Miller-Rabin primality test."""
        if n < 2:
            return False
        if n == 2 or n == 3:
            return True
        if n % 2 == 0:
            return False

        r = 0
        d = n - 1
        while d % 2 == 0:
            r += 1
            d //= 2

        for _ in range(k):
            a = random.randint(2, n - 2)
            x = pow(a, d, n)
            if x == 1 or x == n - 1:
                continue
            for _ in range(r - 1):
                x = pow(x, 2, n)
                if x == n - 1:
                    break
            else:
                return False

        return True

    c_prime = 0
    a, b = 0, 1
    while c_prime < n:
        a, b = b, a + b
        if miller_rabin(b):
            c_prime += 1
    return b

def prime_fib(n: int):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
