def is_prime(n):
    if n < 2:
        return False
    d = 2
    while d * d <= n:
        if n % d == 0:
            return False
        d += 1
    return True

def _orig_x_or_y_spec(n, x, y, output):
    if is_prime(n):
        return output == x
    else:
        return output == y

def x_or_y_spec(n, x, y, output):
    return bool(_orig_x_or_y_spec(n, x, y, output))
