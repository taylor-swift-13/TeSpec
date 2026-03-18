
def modp(n: int, p: int):
    """
    Return 2^n modulo p (be aware of numerics).
    3
    2
    1
    8
    1
    """
    res, x = 1, 2
    while n != 0:
        if n % 2 == 1:
            res = res * x % p
        x = x * x % p
        n //= 2
    return res % p
