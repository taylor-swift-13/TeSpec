def _orig_strlen_spec(s: str, n: int) -> bool:
    return n == len(s)

def strlen_spec(string, output):
    return bool(_orig_strlen_spec(string, output))
