def is_prime(n: int) -> bool:
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

def IsPrime(n: int) -> bool:
    return is_prime(n)

def problem_31_pre(n: int) -> bool:
    return True

def problem_31_spec(n: int, output: bool) -> bool:
    return is_prime(n) == output
