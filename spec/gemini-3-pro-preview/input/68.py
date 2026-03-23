def pluck_spec(arr, res):
    evens = [(x, i) for i, x in enumerate(arr) if x % 2 == 0]
    if not evens:
        expected = []
    else:
        v, i = min(evens, key=lambda pair: (pair[0], pair[1]))
        expected = [v, i]
    return res == expected
