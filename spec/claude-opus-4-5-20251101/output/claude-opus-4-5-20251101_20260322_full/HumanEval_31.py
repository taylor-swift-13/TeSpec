def is_prime_spec(n, result):
    if n <= 1:
        return result == False
    
    is_p = True
    for d in range(2, int(n**0.5) + 1):
        if n % d == 0:
            is_p = False
            break
            
    return result == is_p

def _impl(n):
    if n <= 1: return False
    n_sqrt = 1
    while n_sqrt ** 2 < n: n_sqrt += 1
    for i in range(2, min(n_sqrt + 1, n)):
        if n % i == 0:
            return False
    return True

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_prime_spec(*input, output))

def is_prime(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
