
def is_prime(n):
    """
    Return true if a given number is prime, and false otherwise.
    False
    True
    True
    True
    True
    False
    False
    """
    if n <= 1: return False
    n_sqrt = 1
    while n_sqrt ** 2 < n: n_sqrt += 1
    for i in range(2, min(n_sqrt + 1, n)):
        if n % i == 0:
            return False
    return True
