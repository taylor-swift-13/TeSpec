def IsPrime(n):
    if n <= 1:
        return False
    for d in range(2, int(n**0.5) + 1):
        if n % d == 0:
            return False
    return True

def fib(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
    a, b = 0, 1
    for _ in range(2, n + 1):
        a, b = b, a + b
    return b

def IsFib(n):
    if n < 0:
        return False
    a, b = 0, 1
    while a < n:
        a, b = b, a + b
    return a == n

def IsPrimeFib(n):
    return IsPrime(n) and IsFib(n)

def _orig_problem_39_pre(n):
    return n >= 1

def _orig_problem_39_spec(n, r):
    if not IsPrimeFib(r):
        return False
    count = 0
    for y in range(r):
        if IsPrimeFib(y):
            count += 1
    target = n - 1 if n > 0 else 0
    return count == target

def problem_39_pre(n):
    return bool(_orig_problem_39_pre(n))

def problem_39_spec(n, output):
    return bool(_orig_problem_39_spec(n, output))
