def IsPrime(n):
    if n <= 1:
        return False
    d = 2
    while d * d <= n:
        if n % d == 0:
            return False
        d += 1
    return True

def fib(n):
    if n == 0:
        return 0
    if n == 1:
        return 1
    a, b = 0, 1
    for _ in range(2, n + 1):
        a, b = b, a + b
    return b

def IsFib(n):
    if n < 0:
        return False
    if n == 0:
        return True
    a, b = 0, 1
    while b < n:
        a, b = b, a + b
    return b == n

def IsPrimeFib(n):
    return IsPrime(n) and IsFib(n)

def problem_39_pre(n):
    return n >= 1

def problem_39_spec(n, r):
    if not IsPrimeFib(r):
        return False
    
    # Count the number of Prime Fibonacci numbers strictly less than r.
    # This corresponds to the length of the list S in the Coq spec.
    count = 0
    a, b = 0, 1
    # Iterate through Fibonacci numbers.
    # The sequence b takes values: 1, 1, 2, 3, 5, 8, ...
    # We check primality for each. Since 1 is not prime, duplicates of 1 don't affect the count.
    # For values >= 2, the Fibonacci sequence is strictly increasing, so no duplicates.
    while b < r:
        if IsPrime(b):
            count += 1
        a, b = b, a + b
        
    return count == n - 1

def _impl(n: int):
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

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_39_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_39_spec(*input, output))

def prime_fib(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
