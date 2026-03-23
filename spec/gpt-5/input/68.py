def pluck_spec(arr, res):
    evens = [(x, i) for i, x in enumerate(arr) if x % 2 == 0]
    if not evens:
        expected = []
    else:
        min_even = min(x for x, i in evens)
        first_index = next(i for x, i in evens if x == min_even)
        expected = [min_even, first_index]
    return res == expected
