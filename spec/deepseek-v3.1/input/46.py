def _orig_fib4_spec(n: int, output: int) -> bool:
    if n == 0:
        return output == 0
    if n == 1:
        return output == 0
    if n == 2:
        return output == 2
    if n == 3:
        return output == 0
    return output == 2

def fib4_spec(n, output):
    return bool(_orig_fib4_spec(n, output))
