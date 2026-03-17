
def precondition(args):
    if len(args) != 1:
        return False
    n = args[0]
    return isinstance(n, int) and n >= 1

def postcondition(args, output):
    n = args[0]
    
    # Check output is a positive integer
    if not isinstance(output, int) or output <= 0:
        return False
    
    # Check output is prime
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
    
    # Check output is a Fibonacci number
    def is_fibonacci(num):
        a, b = 0, 1
        while b < num:
            a, b = b, a + b
        return b == num or num == 0
    
    if not is_prime(output):
        return False
    if not is_fibonacci(output):
        return False
    
    # Check it is the n-th such number
    def prime_fibs_up_to_n(n):
        results = []
        a, b = 1, 1
        while len(results) < n:
            if is_prime(b) and is_fibonacci(b):
                results.append(b)
            a, b = b, a + b
            if len(results) == n:
                break
        # Generate enough prime fibs
        count = 0
        a, b = 1, 1
        seen = set()
        while count < n:
            if b not in seen and is_prime(b) and is_fibonacci(b):
                results_list = []
                # restart
                break
        # Simple approach
        prime_fib_list = []
        a, b = 0, 1
        while len(prime_fib_list) < n:
            if is_prime(b) and is_fibonacci(b):
                prime_fib_list.append(b)
            a, b = b, a + b
        return prime_fib_list
    
    prime_fib_list = []
    a, b = 0, 1
    while len(prime_fib_list) < n:
        if is_prime(b) and is_fibonacci(b):
            prime_fib_list.append(b)
        a, b = b, a + b
    
    return prime_fib_list[n - 1] == output

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
