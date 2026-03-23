def sum_list(ds):
    return sum(ds)

def digits_value(ds):
    if not ds:
        return 0
    val = 0
    multiplier = 1
    for d in ds:
        val += d * multiplier
        multiplier *= 10
    return val

def digit(d):
    return 0 <= d <= 9

def all_digits(ds):
    return all(digit(d) for d in ds)

def divides_Z(d, n):
    if d == 0:
        return n == 0
    return n % d == 0

def prime_Z(n):
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

def sum_digits_10(n, s):
    if n < 0:
        return False
    temp_n = n
    digit_sum = 0
    if temp_n == 0:
        digit_sum = 0
    else:
        while temp_n > 0:
            digit_sum += temp_n % 10
            temp_n //= 10
    return s == digit_sum

def max_prime_in_list(lst, p):
    if p not in lst:
        return False
    if not prime_Z(p):
        return False
    primes = [x for x in lst if prime_Z(x)]
    # Since p is in lst and prime_Z(p) is true, primes is not empty
    return p == max(primes)

def skjkasdkd_spec(lst, res):
    primes = [x for x in lst if prime_Z(x)]
    if not primes:
        return False
    p = max(primes)
    return sum_digits_10(p, res)
