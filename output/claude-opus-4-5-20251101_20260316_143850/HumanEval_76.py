
def precondition(input):
    x, n = input
    # x and n must be integers
    if not isinstance(x, int) or not isinstance(n, int):
        return False
    # x must be positive (since we're checking if x = n**k for some non-negative integer k)
    if x < 1:
        return False
    # n must be positive
    if n < 1:
        return False
    return True

def postcondition(input, output):
    x, n = input
    # output must be a boolean
    if not isinstance(output, bool):
        return False
    
    if output:
        # If output is True, then x must be a simple power of n
        # i.e., there exists a non-negative integer k such that n**k == x
        if n == 1:
            # n=1 can only produce 1 (1**k = 1 for all k)
            return x == 1
        else:
            # Check that n**k == x for some non-negative integer k
            k = 0
            power = 1
            while power < x:
                k += 1
                power *= n
            return power == x
    else:
        # If output is False, then x is not a simple power of n
        if n == 1:
            # n=1 can only produce 1
            return x != 1
        else:
            # Verify that no non-negative integer k satisfies n**k == x
            k = 0
            power = 1
            while power < x:
                k += 1
                power *= n
            return power != x

def _impl(x, n):
    """Your task is to write a function that returns true if a number x is a simple
    power of n and false in other cases.
    x is a simple power of n if n**int=x
    For example:
    is_simple_power(1, 4) => true
    is_simple_power(2, 2) => true
    is_simple_power(8, 2) => true
    is_simple_power(3, 2) => false
    is_simple_power(3, 1) => false
    is_simple_power(5, 3) => false"""
    if x == 1: return True
    if n == 0: return x == 0
    if n == 1: return x == 1
    if n == -1: return abs(x) == 1
    p = n
    while abs(p) <= abs(x):
        if p == x: return True
        p = p * n
    return False

def is_simple_power(x, n):
    _input = (x, n)
    assert precondition(_input)
    _output = _impl(x, n)
    assert postcondition(_input, _output)
    return _output
