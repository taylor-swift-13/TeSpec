def is_prime(n):
    if n < 2:
        return False
    d = 2
    while d * d <= n:
        if n % d == 0:
            return False
        d += 1
    return True

def x_or_y_spec(n, x, y, result):
    if is_prime(n):
        return result == x
    else:
        return result == y
