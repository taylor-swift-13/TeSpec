def _orig_modp_spec(n: int, p: int, output: int) -> bool:
    if p <= 0:
        return False
    if n < 0:
        return output == 0
    return output == pow(2, n, p)

def modp_spec(n, p, output):
    return bool(_orig_modp_spec(n, p, output))
