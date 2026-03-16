
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 1:
        return False
    return True

def postcondition(input, output):
    import math

    if not precondition(input):
        return False
    n = input[0]

    if not isinstance(output, int):
        return False
    if output < 2:
        return False

    def is_prime(x):
        if not isinstance(x, int) or x <= 1:
            return False
        if x <= 3:
            return True
        if x % 2 == 0:
            return False
        r = math.isqrt(x)
        f = 3
        while f <= r:
            if x % f == 0:
                return False
            f += 2
        return True

    def is_perfect_square(x):
        if x < 0:
            return False
        s = math.isqrt(x)
        return s * s == x

    def is_fibonacci(x):
        # A number is Fibonacci iff one of 5*x^2+4 or 5*x^2-4 is a perfect square
        if not isinstance(x, int) or x < 0:
            return False
        return is_perfect_square(5 * x * x + 4) or is_perfect_square(5 * x * x - 4)

    if not is_prime(output):
        return False
    if not is_fibonacci(output):
        return False

    # Count prime Fibonacci numbers <= output and ensure that count == n
    count = 0
    a, b = 0, 1
    last_prime_fib = None
    while a <= output:
        if a >= 2 and is_prime(a):
            count += 1
            last_prime_fib = a
        a, b = b, a + b

    if count != n:
        return False
    # Ensure the nth prime Fibonacci equals output
    if last_prime_fib != output:
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
