def _orig_multiply_spec(a: int, b: int, output: int) -> bool:
    return output == abs(a) % 10 * (abs(b) % 10)

def multiply_spec(a, b, output):
    return bool(_orig_multiply_spec(a, b, output))
