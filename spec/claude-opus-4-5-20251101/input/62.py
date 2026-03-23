def _orig_derivative_spec(xs, output):
    expected_len = max(0, len(xs) - 1)
    if len(output) != expected_len:
        return False
    for i in range(len(output)):
        if output[i] != xs[i + 1] * (i + 1):
            return False
    return True

def derivative_spec(xs, output):
    return bool(_orig_derivative_spec(xs, output))
