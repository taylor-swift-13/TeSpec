def _orig_problem_75_pre(a):
    return a < 100

def _orig_problem_75_spec(a, b):
    if a < 8:
        return b == False

    def is_prime(n):
        if n < 2:
            return False
        for i in range(2, int(n ** 0.5) + 1):
            if n % i == 0:
                return False
        return True
    primes = [i for i in range(2, a + 1) if is_prime(i)]
    is_valid = False
    for i in range(len(primes)):
        p1 = primes[i]
        if p1 * p1 * p1 > a:
            break
        for j in range(i, len(primes)):
            p2 = primes[j]
            if p1 * p2 * p2 > a:
                break
            for k in range(j, len(primes)):
                p3 = primes[k]
                prod = p1 * p2 * p3
                if prod == a:
                    is_valid = True
                    break
                elif prod > a:
                    break
            if is_valid:
                break
        if is_valid:
            break
    return b == is_valid

def problem_75_pre(a):
    return bool(_orig_problem_75_pre(a))

def problem_75_spec(a, output):
    return bool(_orig_problem_75_spec(a, output))
