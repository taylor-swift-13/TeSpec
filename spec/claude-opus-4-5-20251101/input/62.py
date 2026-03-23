def derivative_spec(xs, result):
    expected_len = max(0, len(xs) - 1)
    if len(result) != expected_len:
        return False
    for i in range(len(result)):
        if result[i] != xs[i + 1] * (i + 1):
            return False
    return True
