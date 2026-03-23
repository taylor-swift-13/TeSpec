def is_prime(n):
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def problem_59_pre(n):
    return n > 1 and not is_prime(n)

def problem_59_spec(n, p):
    if not is_prime(p):
        return False
    if n == 0:
        return False
    if n % p != 0:
        return False
    
    temp = abs(n)
    largest_prime = -1
    
    if temp % 2 == 0:
        largest_prime = 2
        while temp % 2 == 0:
            temp //= 2
            
    i = 3
    while i * i <= temp:
        if temp % i == 0:
            largest_prime = i
            while temp % i == 0:
                temp //= i
        i += 2
        
    if temp > 2:
        largest_prime = temp
        
    return p == largest_prime

def _impl(n: int):
    isprime = [True] * (n + 1)
    for i in range(2, n + 1):
        if isprime[i]:
            for j in range(i + i, n, i):
                isprime[j] = False
    for i in range(n - 1, 0, -1):
        if isprime[i] and n % i == 0:
            return i

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_59_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_59_spec(*input, output))

def largest_prime_factor(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
