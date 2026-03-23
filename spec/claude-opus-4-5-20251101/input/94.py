def is_prime(n: int) -> bool:
    if n < 2:
        return False
    d = 2
    while d * d <= n:
        if n % d == 0:
            return False
        d += 1
    return True

def sum_of_digits(n: int) -> int:
    acc = 0
    m = n
    for _ in range(100):
        if m <= 0:
            return acc
        acc += m % 10
        m = m // 10
    return acc

def is_largest_prime(x: int, lst: list) -> bool:
    if x not in lst:
        return False
    if not is_prime(x):
        return False
    for y in lst:
        if is_prime(y) and y > x:
            return False
    return True

def skjkasdkd_spec(lst: list, result: int) -> bool:
    primes = [x for x in lst if is_prime(x)]
    if not primes:
        return result == 0
    largest_prime = max(primes)
    return result == sum_of_digits(largest_prime)
