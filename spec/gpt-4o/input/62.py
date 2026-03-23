def _orig_derivative_spec(xs, output):
    expected = [xs[i] * i for i in range(1, len(xs))]
    return output == expected

def derivative_spec(xs, output):
    return bool(_orig_derivative_spec(xs, output))
