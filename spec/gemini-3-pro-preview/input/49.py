def _orig_modp_spec(n: int, p: int, output: int) -> bool:
    if n < 0:
        val = 0
    elif p == 0:
        val = 2 ** n
    elif p > 0:
        val = pow(2, n, p)
    else:
        r_abs = pow(2, n, abs(p))
        val = r_abs + p if r_abs != 0 else 0
    return output == val

def modp_spec(n, p, output):
    return bool(_orig_modp_spec(n, p, output))
