def derivative_spec(xs, result):
    expected = [xs[i] * i for i in range(1, len(xs))]
    return result == expected
