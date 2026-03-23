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

def _orig_problem_59_pre(n):
    return n > 1 and (not is_prime(n))

def _orig_problem_59_spec(n, p):
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

def problem_59_pre(n):
    return bool(_orig_problem_59_pre(n))

def problem_59_spec(n, output):
    return bool(_orig_problem_59_spec(n, output))
