def _orig_pluck_spec(arr, output):
    evens = [(x, i) for (i, x) in enumerate(arr) if x % 2 == 0]
    if not evens:
        expected = []
    else:
        (v, i) = min(evens, key=lambda pair: (pair[0], pair[1]))
        expected = [v, i]
    return output == expected

def pluck_spec(arr, output):
    return bool(_orig_pluck_spec(arr, output))
