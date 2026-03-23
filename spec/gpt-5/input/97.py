def _orig_multiply_spec(a, b, prod):
    return prod == abs(a) % 10 * (abs(b) % 10)

def multiply_spec(a, b, output):
    return bool(_orig_multiply_spec(a, b, output))
