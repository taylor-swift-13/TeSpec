
def precondition(input):
    n = input[0]
    # n must be a non-negative integer
    if not isinstance(n, int):
        return False
    if isinstance(n, bool):
        return False
    if n < 0:
        return False
    return True


def postcondition(input, output):
    n = input[0]
    
    # Output must be a list
    if not isinstance(output, list):
        return False
    
    # Helper function to check if a number is prime
    def is_prime(num):
        if num < 2:
            return False
        if num == 2:
            return True
        if num % 2 == 0:
            return False
        for i in range(3, int(num ** 0.5) + 1, 2):
            if num % i == 0:
                return False
        return True
    
    # All elements in output must be integers
    for x in output:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    
    # All elements must be prime numbers
    for x in output:
        if not is_prime(x):
            return False
    
    # All elements must be less than n
    for x in output:
        if x >= n:
            return False
    
    # Output should be sorted in ascending order
    for i in range(len(output) - 1):
        if output[i] >= output[i + 1]:
            return False
    
    # Output should contain all primes less than n (completeness check)
    expected_primes = [x for x in range(2, n) if is_prime(x)]
    if output != expected_primes:
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
