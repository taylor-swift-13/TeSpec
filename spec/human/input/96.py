def is_prime(n):
    if n < 2:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    d = 3
    while d * d <= n:
        if n % d == 0:
            return False
        d += 2
    return True

def problem_96_pre(n):
    return True

def problem_96_spec(n, result):
    expected = []
    # Generate all primes less than n in increasing order
    for i in range(2, n):
        if is_prime(i):
            expected.append(i)
            
    # The Coq spec requires:
    # 1. All elements in result are prime
    # 2. All elements in result are < n
    # 3. All primes < n are in result
    # 4. result is sorted strictly ascending (Sorted lt)
    # 5. result has no duplicates (NoDup)
    #
    # The list 'expected' satisfies all these properties by construction.
    # Since the set of primes < n is unique and the order is fixed (strictly ascending),
    # 'result' must be exactly equal to 'expected'.
    return result == expected
