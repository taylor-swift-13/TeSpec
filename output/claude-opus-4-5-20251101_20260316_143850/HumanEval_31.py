
def precondition(input):
    n = input[0]
    # n must be an integer
    if not isinstance(n, int):
        return False
    # n must be non-negative (prime definition typically applies to positive integers >= 2)
    if n < 0:
        return False
    return True

def postcondition(input, output):
    n = input[0]
    # Output must be a boolean
    if not isinstance(output, bool):
        return False
    # Check correctness of prime determination
    if n < 2:
        # Numbers less than 2 are not prime
        return output == False
    # Check if n is actually prime
    is_prime = True
    if n == 2:
        is_prime = True
    elif n % 2 == 0:
        is_prime = False
    else:
        i = 3
        while i * i <= n:
            if n % i == 0:
                is_prime = False
                break
            i += 2
    return output == is_prime

def _impl(n):
    """Return true if a given number is prime, and false otherwise.
    False
    True
    True
    True
    True
    False
    False"""
    if n <= 1: return False
    n_sqrt = 1
    while n_sqrt ** 2 < n: n_sqrt += 1
    for i in range(2, min(n_sqrt + 1, n)):
        if n % i == 0:
            return False
    return True

def is_prime(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
