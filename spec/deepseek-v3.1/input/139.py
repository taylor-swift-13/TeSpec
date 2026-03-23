def _orig_special_factorial_spec(n: int, output: int) -> bool:
    if n == 0:
        return output == 1
    if n >= 2:
        return False
    return output == 1

def special_factorial_spec(n, output):
    return bool(_orig_special_factorial_spec(n, output))
