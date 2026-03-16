
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if isinstance(n, bool):  # reject booleans
        return False
    return n >= 0

def postcondition(input, output):
    # Only check postcondition when precondition holds; otherwise vacuously true
    if not precondition(input):
        return True
    n = input[0]

    # Accept lists or tuples as the returned "array"
    if not isinstance(output, (list, tuple)):
        return False

    # Helper: primality check for integers >= 2
    def is_prime(k):
        if not isinstance(k, int) or isinstance(k, bool):
            return False
        if k < 2:
            return False
        if k == 2:
            return True
        if k % 2 == 0:
            return False
        import math
        r = int(math.isqrt(k))
        for i in range(3, r + 1, 2):
            if k % i == 0:
                return False
        return True

    # All elements must be integers (non-bool), primes, >=2 and < n
    prev = None
    for idx, v in enumerate(output):
        if not isinstance(v, int) or isinstance(v, bool):
            return False
        if v < 2 or v >= n:
            return False
        if not is_prime(v):
            return False
        if prev is not None:
            # must be strictly increasing
            if not (prev < v):
                return False
        prev = v

    # Completeness: every prime p where 2 <= p < n must appear in output
    import math
    for p in range(2, n):
        if is_prime(p):
            if p not in output:
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
