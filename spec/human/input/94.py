def sum_digits_fueled(n: int, fuel: int) -> int:
    res = 0
    curr_n = n
    curr_fuel = fuel
    while curr_fuel > 0:
        if curr_n == 0:
            break
        res += curr_n % 10
        curr_n //= 10
        curr_fuel -= 1
    return res

def sum_digits(n: int) -> int:
    return sum_digits_fueled(n, n)

def problem_94_pre(lst: list) -> bool:
    return True

def is_prime(n: int) -> bool:
    if n < 2:
        return False
    if n in (2, 3):
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def problem_94_spec(lst: list, output: int) -> bool:
    primes = [x for x in lst if is_prime(x)]
    if not primes:
        return output == 0
    max_prime = max(primes)
    return output == sum_digits(max_prime)
