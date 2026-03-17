
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 1:
        return False
    n = input_args[0]
    return isinstance(n, int) and n >= 1

def postcondition(input_args, output):
    if not isinstance(output, int) or output < 2:
        return False
    
    # Check if prime
    for i in range(2, int(output**0.5) + 1):
        if output % i == 0:
            return False
            
    # Check if Fibonacci (A number is Fibonacci iff 5*n^2 + 4 or 5*n^2 - 4 is a perfect square)
    def is_perfect_square(x):
        if x < 0: return False
        s = int(x**0.5)
        return s*s == x
        
    val1 = 5 * output * output + 4
    val2 = 5 * output * output - 4
    return is_perfect_square(val1) or is_perfect_square(val2)

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
