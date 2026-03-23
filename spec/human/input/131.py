def get_digits_helper(n, fuel):
    res = []
    while fuel > 0 and n > 0:
        res.append(n % 10)
        n //= 10
        fuel -= 1
    return res

def get_digits(n):
    return get_digits_helper(n, n)

def product(l):
    res = 1
    for x in l:
        res *= x
    return res

def digits_impl(n):
    ds = [x for x in get_digits(n) if x % 2 != 0]
    if not ds:
        return 0
    return product(ds)

def _orig_problem_131_pre(n):
    return n > 0

def _orig_problem_131_spec(n, output):
    return output == digits_impl(n)

def problem_131_pre(n):
    return bool(_orig_problem_131_pre(n))

def problem_131_spec(n, output):
    return bool(_orig_problem_131_spec(n, output))
