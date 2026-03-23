def modp_spec(n: int, p: int, result: int) -> bool:
    if p <= 0:
        return False
    if n < 0:
        return result == 0
    return result == pow(2, n, p)
