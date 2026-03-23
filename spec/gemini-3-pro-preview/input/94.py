def is_prime(n):
    if n <= 1:
        return False
    m = 2
    while m * m <= n:
        if n % m == 0:
            return False
        m += 1
    return True

def digits_sum_aux(n, fuel):
    res = 0
    while fuel > 0 and n > 0:
        res += n % 10
        n //= 10
        fuel -= 1
    return res

def sum_digits(n):
    val = int(n)
    if val < 0:
        val = 0
    return digits_sum_aux(val, val + 1)

def skjkasdkd_spec(lst, res):
    primes = [p for p in lst if is_prime(p)]
    if not primes:
        return False
    max_p = max(primes)
    return res == sum_digits(max_p)
