def _orig_fib_spec(n: int, fib_n: int) -> bool:
    if n == 0:
        return fib_n == 0
    if n == 1 or n == 2:
        return fib_n == 1
    return False

def fib_spec(n, output):
    return bool(_orig_fib_spec(n, output))
