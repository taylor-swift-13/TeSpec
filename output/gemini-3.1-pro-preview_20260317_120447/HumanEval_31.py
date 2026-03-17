
def precondition(input):
    n = input[0]
    return isinstance(n, int)

def postcondition(input, output):
    n = input[0]
    if not isinstance(output, bool):
        return False
    
    is_prime = n > 1
    if is_prime:
        i = 2
        while i * i <= n:
            if n % i == 0:
                is_prime = False
                break
            i += 1
            
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
