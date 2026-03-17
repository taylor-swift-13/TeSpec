
def precondition(inp):
    if len(inp) != 1:
        return False
    n = inp[0]
    return isinstance(n, int) and n >= 0

def postcondition(inp, out):
    n = inp[0]
    if not isinstance(out, list):
        return False
    
    def is_prime(num):
        if not isinstance(num, int) or num < 2:
            return False
        for i in range(2, int(num**0.5) + 1):
            if num % i == 0:
                return False
        return True

    for i, val in enumerate(out):
        if not is_prime(val):
            return False
        if val >= n:
            return False
        if i > 0 and val <= out[i-1]:
            return False
            
    return True

def _impl(n):
    """Implement a function that takes an non-negative integer and returns an array of the first n
    integers that are prime numbers and less than n.
    for example:
    count_up_to(5) => [2,3]
    count_up_to(11) => [2,3,5,7]
    count_up_to(0) => []
    count_up_to(20) => [2,3,5,7,11,13,17,19]
    count_up_to(1) => []
    count_up_to(18) => [2,3,5,7,11,13,17]"""
    ans = []
    isprime = [True] * (n + 1)
    for i in range(2, n):
        if isprime[i]:
            ans.append(i)
            for j in range(i + i, n, i):
                isprime[j] = False
    return ans

def count_up_to(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
