def is_even(n):
    return n % 2 == 0

def _orig_pluck_spec(arr, output):
    evens = [(x, i) for (i, x) in enumerate(arr) if is_even(x)]
    if not evens:
        return output == []
    (min_even, idx) = min(evens, key=lambda pair: (pair[0], pair[1]))
    return output == [min_even, idx]

def pluck_spec(arr, output):
    return bool(_orig_pluck_spec(arr, output))
